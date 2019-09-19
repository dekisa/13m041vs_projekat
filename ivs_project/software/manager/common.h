#ifndef COMMON_H_
#define COMMON_H_

/* BASE */
// parameters are stored in shared OCM
#define MAT_PARAM_BASE	(SHARED_OCM_REGION_BASE + 0x80000000)
// matrices
#define MAT_BUFFER_BASE	(SHARED_SDRAM_REGION_BASE + 0x80000000)

/* OFFSET */
// matrix parameters
#define MAT_WIDTH_OFFSET	(0x00)
#define MAT_HEIGHT_OFFSET	(0x04)
// x,y axis coeff
#define MAT_X_COEFF_OFFSET	(0x08)
#define MAT_Y_COEFF_OFFSET	(0x0A)
// nr heat sources
#define MAT_NR_HEAT_SRC_OFFSET	(0x0C)
// heat sources
#define MAT_HEAT_SRCS_OFFSET	(0x10)
// task descriptions
#define MAT_TASK_DESC_OFFSET	(0x40)

// matrix buffers, allocate 4MB for each
#define MAT_BUF1_OFFSET		(0x00000000)
#define MAT_BUF2_OFFSET		(0x00400000)

/* ADDRESS */
// calculate addresses based on base and offsets
// matrix parameters
#define MAT_WIDTH_ADDR		(MAT_PARAM_BASE + MAT_WIDTH_OFFSET)
#define MAT_HEIGHT_ADDR		(MAT_PARAM_BASE + MAT_HEIGHT_OFFSET)
// x,y axis coeff
#define MAT_X_COEFF_ADDR	(MAT_PARAM_BASE + MAT_X_COEFF_OFFSET)
#define MAT_Y_COEFF_ADDR	(MAT_PARAM_BASE + MAT_Y_COEFF_OFFSET)
// nr heat sources
#define MAT_NR_HEAT_SRC_ADDR	(MAT_PARAM_BASE + MAT_NR_HEAT_SRC_OFFSET)
// heat sources
#define MAT_HEAT_SOURCES_ADDR	(MAT_PARAM_BASE + MAT_HEAT_SRCS_OFFSET)
// task descriptions
#define MAT_TASK_DESC_ADDR	(MAT_PARAM_BASE + MAT_TASK_DESC_OFFSET)

// matrix buffers
#define MAT_BUF1_ADDR		(MAT_BUFFER_BASE + MAT_BUF1_OFFSET)
#define MAT_BUF2_ADDR		(MAT_BUFFER_BASE + MAT_BUF2_OFFSET)

#define	DESC_READY			11
#define	DESC_DONE			22

typedef struct HEAT_SRC
{
	uint16_t xpos;
	uint16_t ypos;
	int16_t heat;
} heat_src_t;


typedef struct DESC
{
	uint32_t id;
	uint32_t row_start;
	uint32_t col_start;
	uint32_t region_width;
	uint32_t region_height;
	uint32_t status;
	int16_t * curr;
	int16_t * next;
} desc_t;

#define MAX_HEAT_SRCS		(5)

#endif /* COMMON_H_ */
