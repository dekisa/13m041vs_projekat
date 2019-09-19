/* 
 * "Small Hello World" example. 
 * 
 * This example prints 'Hello from Nios II' to the STDOUT stream. It runs on
 * the Nios II 'standard', 'full_featured', 'fast', and 'low_cost' example 
 * designs. It requires a STDOUT  device in your system's hardware. 
 *
 * The purpose of this example is to demonstrate the smallest possible Hello 
 * World application, using the Nios II HAL library.  The memory footprint
 * of this hosted application is ~332 bytes by default using the standard 
 * reference design.  For a more fully featured Hello World application
 * example, see the example titled "Hello World".
 *
 * The memory footprint of this example has been reduced by making the
 * following changes to the normal "Hello World" example.
 * Check in the Nios II Software Developers Manual for a more complete 
 * description.
 * 
 * In the SW Application project (small_hello_world):
 *
 *  - In the C/C++ Build page
 * 
 *    - Set the Optimization Level to -Os
 * 
 * In System Library project (small_hello_world_syslib):
 *  - In the C/C++ Build page
 * 
 *    - Set the Optimization Level to -Os
 * 
 *    - Define the preprocessor option ALT_NO_INSTRUCTION_EMULATION 
 *      This removes software exception handling, which means that you cannot 
 *      run code compiled for Nios II cpu with a hardware multiplier on a core 
 *      without a the multiply unit. Check the Nios II Software Developers 
 *      Manual for more details.
 *
 *  - In the System Library page:
 *    - Set Periodic system timer and Timestamp timer to none
 *      This prevents the automatic inclusion of the timer driver.
 *
 *    - Set Max file descriptors to 4
 *      This reduces the size of the file handle pool.
 *
 *    - Check Main function does not exit
 *    - Uncheck Clean exit (flush buffers)
 *      This removes the unneeded call to exit when main returns, since it
 *      won't.
 *
 *    - Check Don't use C++
 *      This builds without the C++ support code.
 *
 *    - Check Small C library
 *      This uses a reduced functionality C library, which lacks  
 *      support for buffering, file IO, floating point and getch(), etc. 
 *      Check the Nios II Software Developers Manual for a complete list.
 *
 *    - Check Reduced device drivers
 *      This uses reduced functionality drivers if they're available. For the
 *      standard design this means you get polled UART and JTAG UART drivers,
 *      no support for the LCD driver and you lose the ability to program 
 *      CFI compliant flash devices.
 *
 *    - Check Access device drivers directly
 *      This bypasses the device file system to access device drivers directly.
 *      This eliminates the space required for the device file system services.
 *      It also provides a HAL version of libc services that access the drivers
 *      directly, further reducing space. Only a limited number of libc
 *      functions are available in this configuration.
 *
 *    - Use ALT versions of stdio routines:
 *
 *           Function                  Description
 *        ===============  =====================================
 *        alt_printf       Only supports %s, %x, and %c ( < 1 Kbyte)
 *        alt_putstr       Smaller overhead than puts with direct drivers
 *                         Note this function doesn't add a newline.
 *        alt_putchar      Smaller overhead than putchar with direct drivers
 *        alt_getchar      Smaller overhead than getchar with direct drivers
 *
 */

#include "sys/alt_stdio.h"

#include <stdint.h>
#include <math.h>
#include "system.h"
#include "../manager/common.h"
#include "altera_avalon_mutex.h"

#define NR_OF_WORKERS		(1)
#define CPU_ID				(1)

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
	desc_t *region;

	uint32_t matrix_size;
	uint32_t iter = 0;

	int16_t * curr;
	int16_t * next;

	mux = altera_avalon_mutex_open(SHARED_OCM_MUTEX_NAME);
	region = &descriptors[CPU_ID];

	while (1)
	{
		while (region->status != DESC_READY)
		{
			usleep(1000);
		}
		for (int y = region->col_start; y < region->col_start + region->region_height-2; y++)
		{
			for (int x = region->row_start; x < region->row_start + region->region_width-2; x++)
			{
				// don't update heat for sources
				uint8_t is_source = 0;
				for (int src = 0; src < *nr_heat_src; src++)
				{
					if ((heat_srcs[src].xpos == x) && (heat_srcs[src].ypos == y))
					{
						is_source = 1;
					}
				}
				uint32_t id = y * *width + x;
				if (is_source)
				{
					region->next[id] = region->curr[id];
				}
				else
				{
					region->next[id] = region->curr[id];
					region->next[id] += _fp_mult(*c_x, (region->curr[id+1] + region->curr[id-1] - (region->curr[id]<<1)));
					region->next[id] += _fp_mult(*c_y, (region->curr[id+*width] + region->curr[id-*width] - (region->curr[id]<<1)));
				}
			}

		}
		while (altera_avalon_mutex_trylock(mux,1))
		{
			usleep(10);
		}
		region->status = DESC_DONE;
		altera_avalon_mutex_unlock(mux);
	}
}
