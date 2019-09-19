#include <stdio.h>
#include <stdint.h>
#include <math.h>
#include "system.h"
#include "common.h"
#include "altera_avalon_mutex.h"

#define MEASURE_PERFORMANCE       // Uncomment this if you want to measure performance
#ifdef MEASURE_PERFORMANCE
#include "altera_avalon_performance_counter.h"
#endif

#define NR_OF_WORKERS		(4)

#if (NR_OF_WORKERS==1)
#define TASK_DONE_MASK		(0x01)
#elif (NR_OF_WORKERS==2)
#define TASK_DONE_MASK		(0x03)
#elif (NR_OF_WORKERS==3)
#define TASK_DONE_MASK		(0x07)
#elif (NR_OF_WORKERS==4)
#define TASK_DONE_MASK		(0x0f)
#endif

uint32_t *width = (uint32_t *)MAT_WIDTH_ADDR;
uint32_t *height = (uint32_t *)MAT_HEIGHT_ADDR;
int16_t *c_x = (int16_t *)MAT_X_COEFF_ADDR;
int16_t *c_y = (int16_t *)MAT_Y_COEFF_ADDR;
int16_t *matrix1 = (int16_t*)MAT_BUF1_ADDR;
int16_t *matrix2 = (int16_t *)MAT_BUF2_ADDR;
uint16_t *nr_heat_src = (uint16_t *)MAT_NR_HEAT_SRC_ADDR;
heat_src_t *heat_srcs = (heat_src_t *)MAT_HEAT_SOURCES_ADDR;
desc_t *descriptors = (desc_t *)MAT_TASK_DESC_ADDR;
alt_mutex_dev *mux;

/**
 * Number of integer bits for Q2.14 fixed point representation
 */
#define FP_INT		(2)

/**
 * Number of fraction bits for Q2.14 fixed point representation
 */
#define FP_FRAC		(14)

/**
 * @brief Correction factor for Q2.14 fixed-point multiplication
 */
#define K    (1 << (FP_FRAC-1))

/**
 * @brief Number 1.0 in Q2.14
 */
#define ONE    (1 << FP_FRAC)

/**
 * @brief Function that multiplies two Q2.14 fixed-point numbers.
 * Note: Overflow isn't included since numbers are <1
 */
int16_t _fp_mult(int16_t a, int16_t b)
{
    int16_t res;
    int32_t tmp;

    tmp = (int32_t)a * (int32_t)b; // result type is operand's type
    // Rounding; mid values are rounded up
    tmp += K;
    // Correct by dividing by base
    res = tmp >> FP_FRAC;

    return res;
}

int main()
{
	uint32_t matrix_size;
	uint32_t iter = 0;

	FILE *fd;
	char fout[64];
	char src[64];
	char tmp[64];

	int16_t * curr;
	int16_t * next;

	mux = altera_avalon_mutex_open(SHARED_OCM_MUTEX_NAME);

	while (1)
	{
#ifdef MEASURE_PERFORMANCE
		PERF_RESET(PERFORMANCE_COUNTER_0_BASE);

    	PERF_START_MEASURING(PERFORMANCE_COUNTER_0_BASE);
#endif /* MEASURE_PERFORMANCE */

		printf("PROGRAM START\n");

		printf("Enter matrix width ");
		scanf("%lu", width);
		*width += 2;	// pad for two pixels along each side
		printf("Enter matrix height ");
		scanf("%lu", height);
		*height += 2;	// pad for two pixels along each side
		printf("Enter sources file name ");
		scanf("%s", tmp);
		snprintf(src, sizeof(src), "%s/%s", ALTERA_HOSTFS_NAME, tmp);

		fd = fopen(src, "rb");
		fread(c_x, sizeof(*c_x), 1, fd);
		fread(c_y, sizeof(*c_y), 1, fd);
		fread(nr_heat_src, sizeof(*nr_heat_src), 1, fd);

		fread(heat_srcs, sizeof(heat_src_t), *nr_heat_src, fd);

		fclose(fd);

		printf("Enter output file name ");
		scanf("%s", tmp);
		snprintf(fout, sizeof(fout), "%s/%s", ALTERA_HOSTFS_NAME, tmp);
		printf("Enter number of iterations ");
		scanf("%lu", &iter);

		matrix_size = *width * *height;
		printf("Matrix size is: %dx%d=%d\n", *width, *height, matrix_size);

		// initialize both matrices
		for (int it = 0; it < matrix_size; it++)
		{
			matrix1[it] = 0;
			matrix2[it] = 0;
		}

		// initialize heat sources
		for (int src = 0; src < *nr_heat_src; src++)
		{
			// add 1 to x and y position since matrix will be padded with zeros along each side
			heat_srcs[src].xpos++;
			heat_srcs[src].ypos++;
			matrix1[heat_srcs[src].ypos * *width + heat_srcs[src].xpos] = heat_srcs[src].heat;
		}

		curr = matrix1;
		next = matrix2;

		for (int i = 0; i < 4; i++)
		{
			descriptors[i].status = DESC_DONE;
		}
#if (NR_OF_WORKERS==1)
		descriptors[0].id = 0;
		descriptors[0].col_start = 1;
		descriptors[0].row_start = 1;
		descriptors[0].region_width = *width;
		descriptors[0].region_height = *height;
		descriptors[0].status = DESC_READY;
		descriptors[0].curr	= curr;
		descriptors[0].next	= next;
		printf("done with desctriptors for 1...");

#elif (NR_OF_WORKERS==2)
		descriptors[0].id = 0;
		descriptors[0].col_start = 1;
		descriptors[0].row_start = 1;
		descriptors[0].region_width = *width;
		descriptors[0].region_height = *height/2+1;
		descriptors[0].status = DESC_READY;
		descriptors[0].curr	= curr;
		descriptors[0].next	= next;

		descriptors[1].id = 0;
		descriptors[1].col_start = *height/2;
		descriptors[1].row_start = 1;
		descriptors[1].region_width = *width;
		descriptors[1].region_height = *height/2+1;
		descriptors[1].status = DESC_READY;
		descriptors[1].curr	= curr;
		descriptors[1].next	= next;
		printf("done with desctriptors for 2...");
		if (descriptors[1].status == DESC_READY)
					printf("descriptors for worker 1 ready...");
		if (descriptors[0].status == DESC_READY)
							printf("descriptors for worker 0 ready...");

#elif (NR_OF_WORKERS==3)
		descriptors[0].id = 0;
		descriptors[0].col_start = 1;
		descriptors[0].row_start = 1;
		descriptors[0].region_width = *width;
		descriptors[0].region_height = *height/3+1;
		descriptors[0].status = DESC_READY;
		descriptors[0].curr	= curr;
		descriptors[0].next	= next;//obradjuje 42 (1-42)

		descriptors[1].id = 0;
		descriptors[1].col_start = *height/3;
		descriptors[1].row_start = 1;
		descriptors[1].region_width = *width;
		descriptors[1].region_height = *height/3+1+1;//obradjuje 43(43-85)
		descriptors[1].status = DESC_READY;
		descriptors[1].curr	= curr;
		descriptors[1].next	= next;

		descriptors[2].id = 0;
		descriptors[2].col_start =  (2 * *height)/3;//obradjuje 21
		descriptors[2].row_start =1;
		descriptors[2].region_width = *width;
		descriptors[2].region_height = *height/3+1+1;
		descriptors[2].status = DESC_READY;
		descriptors[2].curr	= curr;
		descriptors[2].next	= next;
		printf("done with desctriptors for 3...");
#elif (NR_OF_WORKERS==4)
		descriptors[0].id = 0;
		descriptors[0].col_start = 1;
		descriptors[0].row_start = 1;
		descriptors[0].region_width = *width;
		descriptors[0].region_height = *height/4+2;
		descriptors[0].status = DESC_READY;
		descriptors[0].curr	= curr;
		descriptors[0].next	= next;

		descriptors[1].id = 0;
		descriptors[1].col_start = *height/4+1;
		descriptors[1].row_start = 1;
		descriptors[1].region_width = *width;
		descriptors[1].region_height = *height/4+2;
		descriptors[1].status = DESC_READY;
		descriptors[1].curr	= curr;
		descriptors[1].next	= next;

		descriptors[2].id = 0;
		descriptors[2].col_start = (2 * *height)/4;
		descriptors[2].row_start =1 ;
		descriptors[2].region_width = *width;
		descriptors[2].region_height = *height/4+2;
		descriptors[2].status = DESC_READY;
		descriptors[2].curr	= curr;
		descriptors[2].next	= next;

		descriptors[3].id = 0;
		descriptors[3].col_start = (3 * *height)/4;
		descriptors[3].row_start = 1;
		descriptors[3].region_width = *width;
		descriptors[3].region_height = *height/4+2;
		descriptors[3].status = DESC_READY;
		descriptors[3].curr	= curr;
		descriptors[3].next	= next;
#endif
		altera_avalon_mutex_unlock(mux);

#ifdef MEASURE_PERFORMANCE
	// mark beginning of code for which we are interested in performance
		PERF_BEGIN(PERFORMANCE_COUNTER_0_BASE,1);
#endif /* MEASURE_PERFORMANCE */

		for (int i = 0; i < iter; i++)
		{
			while(descriptors[0].status != DESC_DONE)
			{
				usleep(100);
			}
			while(descriptors[1].status != DESC_DONE)
			{
				usleep(100);
			}
			while(descriptors[2].status != DESC_DONE)
			{
				usleep(100);
			}
			while(descriptors[3].status != DESC_DONE)
			{
				usleep(100);
			}

			altera_avalon_mutex_lock(mux,1);
			//altera_avalon_mutex_

			// update next and curr
			int16_t *swap = curr;
			curr = next;
			next = swap;

			for (int i = 0; i < NR_OF_WORKERS; i++)
			{
				descriptors[i].curr	= curr;
				descriptors[i].next	= next;
				descriptors[i].status = DESC_READY;
			}
			altera_avalon_mutex_unlock(mux);

		}


#ifdef MEASURE_PERFORMANCE
		PERF_END(PERFORMANCE_COUNTER_0_BASE,1);
#endif /* MEASURE_PERFORMANCE */


		printf("MATRIX BEGIN\n");

		fd = fopen(fout, "wb");

		*width -= 2;
		*height -= 2;

		fwrite(width, sizeof(uint32_t), 1, fd);
		fwrite(height, sizeof(uint32_t), 1, fd);
		for (int i = 0; i < *height; i++)
		{
			fwrite(&curr[(i + 1) * (*width + 2) + 1],sizeof(uint16_t),*width,fd);
		}

		fflush(fd);

		fclose(fd);

		printf("MATRIX END\n");

		printf("PERF BEGIN\n");
#ifdef MEASURE_PERFORMANCE
		PERF_STOP_MEASURING(PERFORMANCE_COUNTER_0_BASE);

		perf_print_formatted_report((void *)PERFORMANCE_COUNTER_0_BASE,
									alt_get_cpu_freq(),
									1,//PERFORMANCE_COUNTER_0_HOW_MANY_SECTIONS
									"processing");
#endif /* MEASURE_PERFORMANCE */
		printf("PERF END\n");
	}
}
