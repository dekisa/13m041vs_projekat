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
#include <altera_avalon_fifo_util.h>
#include "common.h"

/**
 * START_STRING for Python program
 */
#define START_STRING	"PROGRAM START\n"

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

    // fifo_data
    uint32_t fifo_data = 0;

    // data1 buffer
    data_t data1 = { 0 };

    // data2 buffer
    data_t data2 = { 0 };

    // result buffer
    data_t result = { 0 };

    // initialize DATA FIFO
	altera_avalon_fifo_init(DATA_FIFO_OUT_CSR_BASE,		// base
												0,		// disable interrupts
												2,		// almost empty
												12		// almost full
	);

    // print START_STRING for Python script
    alt_putstr(START_STRING);

    /* Event loop never exits. */
    while (1)
    {
    	// wait until there is data in fifo
    	do
    	{
    		fifo_data = altera_avalon_fifo_read_fifo(DATA_FIFO_OUT_BASE,
    												 DATA_FIFO_OUT_CSR_BASE);
    	} while (fifo_data == 0);

    	data2.d = (fifo_data & 0xffff0000) >> 16;
    	data1.d = result.d = fifo_data & 0x0000ffff;

		// calculate result
		result.d += square(data2.d);

		// write byte 0 - 's'
		alt_putchar('s');

		// write bytes 1-2 - data1
		for (i = 0; i < 2; i++)
		{
			alt_putchar(data1.b[i]);
		}

		// write bytes 3-4 - data2
		for (i = 0; i < 2; i++)
		{
			alt_putchar(data2.b[i]);
		}

		// write bytes 5-6 - result
		for (i = 0; i < 2; i++)
		{
			alt_putchar(result.b[i]);
		}

		// write byte 7 - 't'
		alt_putchar('t');
    }
}
