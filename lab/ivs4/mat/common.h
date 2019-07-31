/*
 * common.h
 *
 *  Created on: Dec 13, 2017
 *      Author: strahinja
 */

#ifndef COMMON_H_
#define COMMON_H_

/* BASE */
// parameters are stored in shared OCM
#define IMAGE_PARAM_BASE	(SHARED_OCM_REGION_BASE + 0x80000000)
// input and output images are stored in shared SDRAM
#define IMAGE_BUFFER_BASE	(SHARED_SDRAM_REGION_BASE + 0x80000000)

/* OFFSET */
// image parameters
#define IMAGE_WIDTH_OFFSET	(0x00)
#define IMAGE_HEIGHT_OFFSET	(0x04)
// descriptor offset
#define DESC_START_OFFSET	(0x00000020)

// image buffers, allocate 4MB for each
#define IMAGE_IN_OFFSET		(0x00000000)
#define IMAGE_OUT_OFFSET	(0x00400000)

/* ADDRESS */
// calculate addresses based on base and offsets
// image parameters
#define IMAGE_WIDTH_ADDR	(IMAGE_PARAM_BASE + IMAGE_WIDTH_OFFSET)
#define IMAGE_HEIGHT_ADDR	(IMAGE_PARAM_BASE + IMAGE_HEIGHT_OFFSET)
// descriptor address
#define DESC_START_ADDR		(IMAGE_PARAM_BASE + DESC_START_OFFSET)

// image buffers
#define IMAGE_IN_ADDR		(IMAGE_BUFFER_BASE + IMAGE_IN_OFFSET)
#define IMAGE_OUT_ADDR		(IMAGE_BUFFER_BASE + IMAGE_OUT_OFFSET)

#define LINEAR

typedef struct DESC
{
	uint32_t id;
	uint32_t row_start;
	uint32_t col_start;
	uint32_t region_width;
	uint32_t region_height;
	uint32_t status;
	uint32_t reserved[2];	// put on 32 byte boundary 0x20
} desc_t;

typedef enum DESC_STATUS_ENUM
{
	DESC_READY,
	DESC_PROCESSING,
	DESC_DONE
} desc_status_t;


#endif /* COMMON_H_ */
