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

#include <stdlib.h>
#include <stdint.h>
#include "sys/alt_stdio.h"
#include "sys/alt_irq.h"
#include "system.h"
#include "altera_avalon_fifo_util.h"
#include "altera_avalon_mailbox_simple.h"

/**
 * @brief Correction factor for Q1.15 fixed-point multiplication
 */
#define K    (1 << 14)

typedef enum MCMODE_ENUM {
	INIT,
	CIRCLE,
	INTEGRAL
} mcmode_t;

typedef struct MCSIM_STRUCT {
	uint32_t valid;
	uint32_t total;
} mcsim_t;

altera_avalon_mailbox_dev * mbox;

volatile mcmode_t mode_next = INIT;
volatile uint32_t resolution = 1000;

static void mailbox_handle(void *message)
{
	uint32_t* data = (uint32_t *)message;

	mode_next = data[0];
	resolution = data[1];
}

/**
 * @brief Function that multiplies two Q1.15 fixed-point numbers.
 * Note: Overflow isn't included since numbers are <1
 */
uint16_t mult(uint16_t a, uint16_t b)
{
    uint16_t res;
    uint32_t tmp;

    tmp = (uint32_t)a * (uint32_t)b; // result type is operand's type
    // Rounding; mid values are rounded up
    tmp += K;
    // Correct by dividing by base
    res = tmp >> 15;

    return res;
}

/**
 * @brief Function that calculates square function for Q1.15 fixed-point
 */
uint16_t square(uint16_t a)
{
    return mult(a,a);
}



int main()
{
	mcmode_t mode = INIT;
	mcsim_t count = {0};
	uint16_t p_x, p_y, sum;

    // Initialize random generator
    srand(1);

	altera_avalon_fifo_init(FIFO_CLIENT0_IN_CSR_BASE, 0, 2, 12);

    // initialize mailbox
    mbox = altera_avalon_mailbox_open("/dev/mbox_client0", NULL, mailbox_handle);

    // Run simulation
    for (;;)
    {
    	if (mode_next == INIT)
    	{
    		mode = INIT;
    	}
    	else
    	{
			if (mode != mode_next)
			{
				mode = mode_next;
				count.valid = count.total = 0;
			}

			p_x = (uint16_t)((uint32_t)rand() >> 16);
			p_y = (uint16_t)((uint32_t)rand() >> 16);
			switch (mode)
			{
			case CIRCLE:
				{
					sum = square(p_x) + square(p_y);
				}
				break;
			case INTEGRAL:
				{
					sum = mult(((1 << 15) + square(p_x)), p_y);
				}
				break;
			default:
				sum = 0;
				break;
			}
			if (sum <= (1 << 15))
			{
				count.valid++;
			}
			count.total++;

			if (0 == (count.total % resolution))
			{
				altera_avalon_fifo_write_fifo(FIFO_CLIENT0_IN_BASE,FIFO_CLIENT0_IN_CSR_BASE,count.valid);
				count.total = count.valid = 0;
//				altera_avalon_fifo_write_fifo(FIFO_CLIENT0_IN_BASE,FIFO_CLIENT0_IN_CSR_BASE,count.total);
			}
    	}
    }
}
