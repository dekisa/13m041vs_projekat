/**
 * @file main-cpu0.c
 * @brief CPU0 calculates square of one number, sums everything and sends to PC
 * @details
 * CPU which receives data from first CPU and calculates square of the other
 * number. Result is sent to PC.
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
#include <altera_avalon_mutex.h>
#include "common.h"
#include "ringbuf.h"

/**
 * START_STRING for Python program
 */
#define START_STRING	"PROGRAM START\n"

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

int main()
{
    // help counter
    uint8_t i;

    // ret value
    uint8_t retval = 0;

    // item data
    item_t item = { { 0 } };

    // initialize mutex
    mux = altera_avalon_mutex_open("/dev/mutex");

    // initialize ringbuffer
    while (altera_avalon_mutex_first_lock(mux));
    ringbuf_init(0);

    // print START_STRING for Python script
    alt_putstr(START_STRING);

    /* Event loop never exits. */
    while (1)
    {
    	// dequeue data
		altera_avalon_mutex_lock(mux, 0xa5);
		retval = ringbuf_dequeue(&item);
		altera_avalon_mutex_unlock(mux);

		if (retval == 0)
		{
			// calculate result
			item.result.d += square(item.data2.d);

			// write byte 0 - 's'
			alt_putchar('s');

			// write bytes 1-2 - data1
			for (i = 0; i < 2; i++)
			{
				alt_putchar(item.data1.b[i]);
			}

			// write bytes 3-4 - data2
			for (i = 0; i < 2; i++)
			{
				alt_putchar(item.data2.b[i]);
			}

			// write bytes 5-6 - result
			for (i = 0; i < 2; i++)
			{
				alt_putchar(item.result.b[i]);
			}

			// write byte 7 - 't'
			alt_putchar('t');
		}
    }
}
