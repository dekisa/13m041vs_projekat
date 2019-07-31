/**
 * @file main.c
 * @brief Single CPU that implements sum of squares
 * @details
 * Example system which receives data from data generation component and
 * calculates sum of squares.
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

/**
 * @brief Correction factor for Q1.14 fixed-point multiplication
 */
#define K    (1 << 13)

/**
 * START_STRING for Python program
 */
#define START_STRING	"PROGRAM START\n"

/**
 * Data union which holds 16 bit value so it can be accessed on a byte boundary
 */
typedef union DATA_UNION {
    uint16_t d;
    uint8_t b[2];
} data_t;

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
    // help counter
    int i;

    // result buffer
    data_t result = { 0 };

    // register ISR
    alt_ic_isr_register(DATAGEN_IRQ_INTERRUPT_CONTROLLER_ID,
                        DATAGEN_IRQ,
                        data_gen_handler,
                        0,
                        0);

    // print START_STRING for Python script
    alt_putstr(START_STRING);

    /* Event loop never exits. */
    while (1)
    {
        if (flag)
        {
        	// calculate result
        	result.d = square(data1.d) + square(data2.d);

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

            // clear sync flag
            flag = 0;
        }
    }
}
