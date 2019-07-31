#include <stdio.h>
#include <stdint.h>
#include "altera_avalon_mailbox_simple.h"
#include "altera_avalon_fifo_util.h"
#include "system.h"
#include "common.h"

#define MEASURE_PERFORMANCE       // Uncomment this if you want to measure performance
#ifdef MEASURE_PERFORMANCE
#include "altera_avalon_performance_counter.h"
#endif

#define NR_OF_WORKERS		(4)

#define TOTAL_TASK_COUNT	(16)
#define IMAGE_DIV			(4)		// sqrt(TOTAL_TASK_COUNT)

uint32_t *width = (uint32_t *)IMAGE_WIDTH_ADDR;
uint32_t *height = (uint32_t *)IMAGE_HEIGHT_ADDR;
desc_t *descriptors = (desc_t *)DESC_START_ADDR;
uint8_t *image_in = (uint8_t *)IMAGE_IN_ADDR;
uint8_t *image_out = (uint8_t *)IMAGE_OUT_ADDR;

altera_avalon_mailbox_dev *mboxes[NR_OF_WORKERS];

int main()
{
	uint32_t image_size;
	uint32_t task_count = 0;
	uint32_t processing_count = 0;
	uint32_t req;
	uint32_t message[2];

	FILE *fd;
	char fin[64];
	char fout[64];
	char tmp[64];

	altera_avalon_fifo_init(REQ_FIFO_OUT_CSR_BASE, 0, 2, 12);

	mboxes[0] = altera_avalon_mailbox_open(MBOX_M_W0_NAME, NULL, NULL);
#if NR_OF_WORKERS >= 2
	mboxes[1] = altera_avalon_mailbox_open(MBOX_M_W1_NAME, NULL, NULL);
#if NR_OF_WORKERS >= 3
	mboxes[2] = altera_avalon_mailbox_open(MBOX_M_W2_NAME, NULL, NULL);
#if NR_OF_WORKERS == 4
	mboxes[3] = altera_avalon_mailbox_open(MBOX_M_W3_NAME, NULL, NULL);
#endif
#endif
#endif

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

		// build descriptors
		for (int i = 0; i < TOTAL_TASK_COUNT; i++)
		{
			descriptors[i].id = i;
			descriptors[i].col_start = i/IMAGE_DIV* *width;
			descriptors[i].row_start = i%IMAGE_DIV * *height;
			descriptors[i].region_width = *width/IMAGE_DIV;
			descriptors[i].region_height = *height/IMAGE_DIV;
		}
		task_count = 0;
		processing_count = 0;

		// start processing
#ifdef MEASURE_PERFORMANCE
	// mark beginning of code for which we are interested in performance
		PERF_BEGIN(PCU_BASE,1);
#endif /* MEASURE_PERFORMANCE */

		// initialize workers
		for (int i=0; i<NR_OF_WORKERS; i++)
		{
			message[0] = task_count;
			altera_avalon_mailbox_send(mboxes[i], &message, 0, POLL);
			processing_count++;
			task_count++;
		}

		do {
			// wait for request
			while(!altera_avalon_read_fifo(REQ_FIFO_OUT_BASE,REQ_FIFO_OUT_CSR_BASE, (int *)&req));
			uint16_t mbox_id = (req >> 16) & 0x0000ffff;
			processing_count--;
			if (task_count < TOTAL_TASK_COUNT)
			{
				// dispatch new task
				message[0] = task_count;
				altera_avalon_mailbox_send(mboxes[mbox_id], &message, 0, POLL);
				processing_count++;
				task_count++;
			}
			else
			{
				message[0] = 0xffffffff;
				altera_avalon_mailbox_send(mboxes[mbox_id], &message, 0, POLL);
			}
		} while (processing_count > 0);

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
