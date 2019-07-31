#include <stdio.h>
#include <stdint.h>
#include <unistd.h>
#include <math.h>
#include "altera_avalon_fifo_util.h"
#include "altera_avalon_mutex.h"
#include "system.h"
#include "common.h"

uint32_t *width = (uint32_t *)IMAGE_WIDTH_ADDR;
uint32_t *height = (uint32_t *)IMAGE_HEIGHT_ADDR;
desc_t *descriptors = (desc_t *)DESC_START_ADDR;
uint8_t *image_in = (uint8_t *)IMAGE_IN_ADDR;
uint8_t *image_out = (uint8_t *)IMAGE_OUT_ADDR;

// mutex pointer
alt_mutex_dev *mux;

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
	desc_t *region;

    // initialize mutex
    mux = altera_avalon_mutex_open(BARRIER_NAME);

	altera_avalon_fifo_init(ACK_FIFO_IN_CSR_BASE,	// base
							0,						// not using interrupts
							2,						// almost empty flag
							11						// almost full flag
	);

	while (1)
	{
		// wait until mutex is unlocked
		while (altera_avalon_mutex_trylock(mux,1))
		{
			usleep(1000);
		}

		region = &descriptors[0];
		switch (region->status)
		{
		case DESC_READY:
			region->status = DESC_PROCESSING;
			break;
		case DESC_PROCESSING:
			region->status = DESC_DONE;
			break;
		default:
			break;
		}

		// unlock mutex
		altera_avalon_mutex_unlock(mux);

		if (DESC_DONE == region->status)
		{
			// task already done
			usleep(1000000);
		}
		else
		{
//			printf("starting region %lu\n", region->id);

			for (int h = 0; h < region->region_height; h++)
			{
				for (int w = 0; w < region->region_width; w++)
				{
					uint32_t px = ((region->row_start + h) * *width) + region->col_start + w;
#ifdef LINEAR
					process_lin(px);
#else
					process_pow(px);
#endif
				}
			}

			// region is finished
//			printf("region %lu done!\n", region->id);
			altera_avalon_fifo_write_fifo(ACK_FIFO_IN_BASE,ACK_FIFO_IN_CSR_BASE,region->id);

		}
	}
}
