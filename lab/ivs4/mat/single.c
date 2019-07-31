#include <stdio.h>
#include <stdint.h>
#include <math.h>
#include "system.h"
#include "common.h"

#define MEASURE_PERFORMANCE       // Uncomment this if you want to measure performance
#ifdef MEASURE_PERFORMANCE
#include "altera_avalon_performance_counter.h"
#endif

uint32_t *width = (uint32_t *)IMAGE_WIDTH_ADDR;
uint32_t *height = (uint32_t *)IMAGE_HEIGHT_ADDR;
uint8_t *image_in = (uint8_t *)IMAGE_IN_ADDR;
uint8_t *image_out = (uint8_t *)IMAGE_OUT_ADDR;

#ifdef LINEAR
static inline void process_lin(uint32_t px)
{
	double tmp = (double)(image_in[px])/184.*255. - 13260./184;
	image_out[px] = (uint8_t)(tmp > 0 ? tmp : 0);
}
#else
static inline void process_pow(uint32_t px)
{
	double tmp = (double)(image_in[px])-56;
	image_out[px] = (uint8_t)((tmp > 0) ? 255*pow(tmp/255,0.6) : 0);
}
#endif

int main()
{
	uint32_t px = 0;

	uint32_t image_size;

	FILE *fd;
	char fin[64];
	char fout[64];
	char tmp[64];

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

#ifdef MEASURE_PERFORMANCE
	// mark beginning of code for which we are interested in performance
		PERF_BEGIN(PCU_BASE,1);
#endif /* MEASURE_PERFORMANCE */

		for (px = 0; px < image_size; px++)
		{
#ifdef LINEAR
			process_lin(px);
#else
			process_pow(px);
#endif
		}

#ifdef MEASURE_PERFORMANCE
		PERF_END(PCU_BASE,1);
#endif /* MEASURE_PERFORMANCE */


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
