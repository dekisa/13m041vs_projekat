#include <stdio.h>
#include <stdint.h>
#include "altera_avalon_fifo_util.h"
#include "altera_avalon_mutex.h"
#include "system.h"
#include "common.h"

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

uint32_t *width = (uint32_t *)IMAGE_WIDTH_ADDR;
uint32_t *height = (uint32_t *)IMAGE_HEIGHT_ADDR;
desc_t *descriptors = (desc_t *)DESC_START_ADDR;
uint8_t *image_in = (uint8_t *)IMAGE_IN_ADDR;
uint8_t *image_out = (uint8_t *)IMAGE_OUT_ADDR;

alt_mutex_dev *mux;

int main()
{
	uint32_t image_size;
	uint32_t ack;
	uint32_t task_done = 0;

	FILE *fd;
	char fin[64];
	char fout[64];
	char tmp[64];

	altera_avalon_fifo_init(ACK_FIFO_OUT_CSR_BASE,
							0,
							2,
							12
	);

	mux = altera_avalon_mutex_open(BARRIER_NAME);

	while (1)
	{
#ifdef MEASURE_PERFORMANCE
		PERF_RESET(PCU_BASE);

    	PERF_START_MEASURING(PCU_BASE);
#endif /* MEASURE_PERFORMANCE */

		printf("PROGRAM START\n");

		printf("Enter image name ");
		scanf("%s", tmp);
		snprintf(fin, sizeof(fin), "%s/%s", ALTERA_HOSTFS_NAME, tmp);
		snprintf(fout, sizeof(fout), "%s/%s.out", ALTERA_HOSTFS_NAME, tmp);
		printf("Enter image width ");
		scanf("%lu", width);
		printf("Enter image height ");
		scanf("%lu", height);


		image_size = *width * *height;

		fd = fopen(fin,"rb");

		fread(image_in,sizeof(alt_u8),image_size,fd);

		fclose(fd);

		for (int i = 0; i < 4; i++)
		{
			descriptors[i].status = DESC_DONE;
		}

#if (NR_OF_WORKERS==1)
		descriptors[0].id = 0;
		descriptors[0].col_start = 0;
		descriptors[0].row_start = 0;
		descriptors[0].region_width = *width;
		descriptors[0].region_height = *height;
		descriptors[0].status = DESC_READY;
#elif (NR_OF_WORKERS==2)
		descriptors[0].id = 0;
		descriptors[0].col_start = 0;
		descriptors[0].row_start = 0;
		descriptors[0].region_width = *width;
		descriptors[0].region_height = *height/2;
		descriptors[0].status = DESC_READY;

		descriptors[1].id = 0;
		descriptors[1].col_start = 0;
		descriptors[1].row_start = *height/2;
		descriptors[1].region_width = *width;
		descriptors[1].region_height = *height/2;
		descriptors[1].status = DESC_READY;
#elif (NR_OF_WORKERS==3)
		descriptors[0].id = 0;
		descriptors[0].col_start = 0;
		descriptors[0].row_start = 0;
		descriptors[0].region_width = *width;
		descriptors[0].region_height = *height/3;
		descriptors[0].status = DESC_READY;

		descriptors[1].id = 0;
		descriptors[1].col_start = 0;
		descriptors[1].row_start = *height/3;
		descriptors[1].region_width = *width;
		descriptors[1].region_height = *height/3;
		descriptors[1].status = DESC_READY;

		descriptors[2].id = 0;
		descriptors[2].col_start = 0;
		descriptors[2].row_start = *height/3;
		descriptors[2].region_width = *width;
		descriptors[2].region_height = *height/3+1;
		descriptors[2].status = DESC_READY;
#elif (NR_OF_WORKERS==4)
		descriptors[0].id = 0;
		descriptors[0].col_start = 0;
		descriptors[0].row_start = 0;
		descriptors[0].region_width = *width;
		descriptors[0].region_height = *height/4;
		descriptors[0].status = DESC_READY;

		descriptors[1].id = 0;
		descriptors[1].col_start = 0;
		descriptors[1].row_start = *height/4;
		descriptors[1].region_width = *width;
		descriptors[1].region_height = *height/4;
		descriptors[1].status = DESC_READY;

		descriptors[2].id = 0;
		descriptors[2].col_start = 0;
		descriptors[2].row_start = *height/4;
		descriptors[2].region_width = *width;
		descriptors[2].region_height = *height/4;
		descriptors[2].status = DESC_READY;

		descriptors[3].id = 0;
		descriptors[3].col_start = 0;
		descriptors[3].row_start = *height/4;
		descriptors[3].region_width = *width;
		descriptors[3].region_height = *height/4;
		descriptors[3].status = DESC_READY;
#endif

		altera_avalon_mutex_unlock(mux);

#ifdef MEASURE_PERFORMANCE
	// mark beginning of code for which we are interested in performance
		PERF_BEGIN(PCU_BASE,1);
#endif /* MEASURE_PERFORMANCE */

		while (task_done != 0x01) {
			while (!altera_avalon_read_fifo(ACK_FIFO_OUT_BASE, ACK_FIFO_OUT_CSR_BASE, (int *)&ack));
			task_done |= 1 << ack;
		}
		task_done = 0;

#ifdef MEASURE_PERFORMANCE
		PERF_END(PCU_BASE,1);
#endif /* MEASURE_PERFORMANCE */

		// lock mutex
		altera_avalon_mutex_lock(mux, 1);


		printf("IMAGE BEGIN\n");

		fd = fopen(fout, "wb");

		fwrite(image_out,sizeof(uint8_t),image_size,fd);
		fflush(fd);

		fclose(fd);

		printf("IMAGE END\n");

		printf("PERF BEGIN\n");
#ifdef MEASURE_PERFORMANCE
		PERF_STOP_MEASURING(PCU_BASE);

		perf_print_formatted_report((void *)PCU_BASE,
									alt_get_cpu_freq(),
									PCU_HOW_MANY_SECTIONS);
#endif /* MEASURE_PERFORMANCE */
		printf("PERF END\n");
	}
}
