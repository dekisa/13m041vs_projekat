#include <stdio.h>
#include <stdint.h>
#include <unistd.h>
#include <math.h>
#include "altera_avalon_fifo_util.h"
#include "altera_avalon_mailbox_simple.h"
#include "system.h"
#include "common.h"

#define WID		(0)

uint32_t *width = (uint32_t *)IMAGE_WIDTH_ADDR;
uint32_t *height = (uint32_t *)IMAGE_HEIGHT_ADDR;
desc_t *descriptors = (desc_t *)DESC_START_ADDR;
uint8_t *image_in = (uint8_t *)IMAGE_IN_ADDR;
uint8_t *image_out = (uint8_t *)IMAGE_OUT_ADDR;

altera_avalon_mailbox_dev *mbox;

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
	uint32_t message[2];

	altera_avalon_fifo_init(REQ_FIFO_IN_CSR_BASE,	// base
							0,						// not using interrupts
							2,						// almost empty flag
							11						// almost full flag
	);

	mbox = altera_avalon_mailbox_open(MBOX_M_W0_NAME, NULL, NULL);

	while (1)
	{
		// wait until first task is received
		altera_avalon_mailbox_retrieve_poll(mbox, (alt_u32*)&message, 0);

		// check if it is ending
		while (message[0] != 0xffffffff)
		{
			region = &descriptors[message[0]];
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
			int32_t req = (WID << 16) | region->id;
			// send results and request new data
			altera_avalon_fifo_write_fifo(REQ_FIFO_IN_BASE,REQ_FIFO_IN_CSR_BASE,req);
			// start new task
			altera_avalon_mailbox_retrieve_poll(mbox, (alt_u32*)&message, 0);
		}
	}
}
