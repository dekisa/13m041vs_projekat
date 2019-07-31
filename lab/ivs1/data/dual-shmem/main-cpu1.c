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
#include "common.h"
#include "ringbuf.h"
#include <altera_avalon_mutex.h>

/**
 * item buffer
 */
volatile item_t item = { { 0 } };

/**
 * Synchronization flag between ISR and main loop
 */
volatile uint8_t flag = 0;

/**
 * mutex pointer
 */
alt_mutex_dev *mux;

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

	item.data1.d = (data & 0xffff0000) >> 16;
	item.data2.d = data & 0x0000ffff;

    // Set flag so main loop can start execution
    flag = 1;
}

int main()
{
    // initialize mutex
    mux = altera_avalon_mutex_open("/dev/mutex");

    // initialize ringbuffer
    ringbuf_init(1);

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
        	item.result.d = square(item.data1.d);

			altera_avalon_mutex_lock(mux, 0xa5);
        	ringbuf_enqueue(item);
		    altera_avalon_mutex_unlock(mux);
            // clear sync flag
            flag = 0;
        }
    }
}
