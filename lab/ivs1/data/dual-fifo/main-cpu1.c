/**
 * @file main-cpu1.c
 * @brief CPU that handles data gen and calculates square of one number
 * @details
 * CPU which receives data from data generation component and
 * calculates square of one number. Result and other number are stored into
 * FIFO so other CPU can finish calculation.
 *
 * Embedded Multiprocessor Systems
 * University of Belgrade - School of Electrical Engineering
 * 
 * @date 2017
 */

#include <sys/alt_stdio.h>
#include <sys/alt_irq.h>
#include <io.h>
#include <stdint.h>
#include <system.h>
#include <altera_avalon_fifo_util.h>
#include "common.h"

/**
 * data1 buffer
 */
volatile data_t data1 = { 0 };

/**
 * data2 buffer
 */
volatile data_t data2 = { 0 };

/**
 * Synchronization flag between ISR and main loop
 */
volatile uint8_t flag = 0;

/**
 * @brief Function that calculates square function for Q1.14 fixed-point
 */
int16_t square(int16_t a)
{
    int16_t res;
    int32_t tmp;

    tmp = (int32_t)a * (int32_t)a; // result type is operand's type
    // Rounding; mid values are rounded up
    tmp += K;
    // Correct by dividing by base
    res = tmp >> 14;

    return res;
}

/**
 * @brief Handler for data generation component ISR
 */
void data_gen_handler(void *context)
{
	// Read data
	int32_t data = IORD(DATAGEN_BASE, 0);

	data1.d = (data & 0xffff0000) >> 16;
	data2.d = data & 0x0000ffff;

    // Set flag so main loop can start execution
    flag = 1;
}

int main()
{
    // data to be sent to fifo
    uint32_t data;

    // initialize DATA FIFO
	altera_avalon_fifo_init(DATA_FIFO_IN_CSR_BASE,		// base
												0,		// disable interrupts
												2,		// almost empty
												12		// almost full
	);

    // register ISR
    alt_ic_isr_register(DATAGEN_IRQ_INTERRUPT_CONTROLLER_ID,
                        DATAGEN_IRQ,
                        data_gen_handler,
                        0,
                        0);

    /* Event loop never exits. */
    while (1)
    {
        if (flag)
        {
        	// calculate result
        	data = (data2.d << 16) | (square(data1.d) & 0x0000ffff);

			// write data to FIFO
        	altera_avalon_fifo_write_fifo(DATA_FIFO_IN_BASE,
        							      DATA_FIFO_IN_CSR_BASE,
        							      data);

            // clear sync flag
            flag = 0;
        }
    }
}
