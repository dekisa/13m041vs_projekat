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
#define IMAGE_PARAM_BASE	(SHARED_OCM_REGION_BASE)
// input and output images are stored in shared SDRAM
#define IMAGE_BUFFER_BASE	(SHARED_SDRAM_REGION_BASE)

/* OFFSET */
// image parameters
#define IMAGE_WIDTH_OFFSET	(0x00)
#define IMAGE_HEIGHT_OFFSET	(0x04)

// image buffers, allocate 4MB for each
#define IMAGE_IN_OFFSET		(0x00000000)
#define IMAGE_OUT_OFFSET	(0x00400000)

/* ADDRESS */
// calculate addresses based on base and offsets
// image parameters
#define IMAGE_WIDTH_ADDR	(IMAGE_PARAM_BASE + IMAGE_WIDTH_OFFSET)
#define IMAGE_HEIGHT_ADDR	(IMAGE_PARAM_BASE + IMAGE_HEIGHT_OFFSET)

// image buffers
#define IMAGE_IN_ADDR		(IMAGE_BUFFER_BASE + IMAGE_IN_OFFSET)
#define IMAGE_OUT_ADDR		(IMAGE_BUFFER_BASE + IMAGE_OUT_OFFSET)

#define LINEAR

#endif /* COMMON_H_ */
