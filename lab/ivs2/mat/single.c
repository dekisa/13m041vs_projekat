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
#include <stdio.h>
#include <stdint.h>
#include "sys/alt_stdio.h"
#include "sys/alt_irq.h"
#include "system.h"
#include "altera_avalon_pio_regs.h"

//#define MEASURE_PERFORMANCE
//#define PRINT_CURRENT
#define PRINT_PYTHON

#ifdef MEASURE_PERFORMANCE
#include "altera_avalon_performance_counter.h"
#endif

#define MODE_SELECT_BIT_MASK		(0x01)

#define PI							(3.141592F)
#define RES							(0.00001)

/**
 * START_STRING for Python program
 */
#define START_STRING	"PROGRAM START\n"

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

typedef union FLOAT_UNION {
	float val;
	uint8_t b[4];
} floatu_t;

typedef union UINT_UNION {
	uint32_t val;
	uint8_t b[4];
} uint32u_t;

static void pio_handle(void *context)
{
	mcmode_t * m = (mcmode_t *)context;

	if (MODE_SELECT_BIT_MASK == IORD_ALTERA_AVALON_PIO_DATA(PIO_BASE))
	{
		*m = CIRCLE;
	}
	else
	{
		*m = INTEGRAL;
	}

	IOWR_ALTERA_AVALON_PIO_EDGE_CAP(PIO_BASE, MODE_SELECT_BIT_MASK);
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
	volatile mcmode_t mode_next = (MODE_SELECT_BIT_MASK == IORD_ALTERA_AVALON_PIO_DATA(PIO_BASE)) ? CIRCLE : INTEGRAL;
	volatile uint8_t recalculate = 0;
	mcsim_t count = {0};
	uint16_t p_x, p_y, sum;
	uint16_t resolution = 1000;
	uint8_t done = 0;
#ifdef PRINT_CURRENT
	uint8_t print_cnt = 0;
#endif /* PRINT_CURRENT */


    // Initialize random generator
    srand(0);

    // Initialize performance counter
#ifdef MEASURE_PERFORMANCE
    PERF_RESET(PERFMON_BASE);
#endif /* MEASURE_PERFORMANCE */

    // Initialize PIO
    alt_ic_isr_register(PIO_IRQ_INTERRUPT_CONTROLLER_ID,	// cid
    					PIO_IRQ,							// irq nr
    					pio_handle,							// isr
    					(void *)&mode_next,						// ctxt
    					0x0);								// reserved

    // reset flags
    IOWR_ALTERA_AVALON_PIO_EDGE_CAP(PIO_BASE, MODE_SELECT_BIT_MASK);
    // enable interrupts
    IOWR_ALTERA_AVALON_PIO_IRQ_MASK(PIO_BASE, MODE_SELECT_BIT_MASK);

    // print START_STRING for Python script
    alt_putstr(START_STRING);

    // Run simulation
    for (;;)
    {
    	if (mode != mode_next)
    	{
    		mode = mode_next;
    		count.valid = count.total = done = 0;
#ifdef PRINT_CURRENT
    		printf("START %s\n", (CIRCLE == mode) ? "CIRCLE": "INTEGRAL");
    		print_cnt = 0;
#endif /* PRINT_CURRENT */
#ifdef MEASURE_PERFORMANCE
    		// mark beginning of code for which we are interested in performance
    		PERF_START_MEASURING(PERFMON_BASE);
    		PERF_BEGIN(PERFMON_BASE, mode);
#endif /* MEASURE_PERFORMANCE */

    	}

		if (done == 0)
		{
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
				recalculate = 1;
			}

			if (recalculate)
			{
				recalculate = 0;
				alt_irq_context ctxt = alt_irq_disable_all();

				floatu_t pi_est;
				pi_est.val = (4.0 * count.valid) / count.total;

				if (pi_est.val > PI)
				{
					if ((pi_est.val - PI) < RES)
					{
						done = 1;
					}
				}
				else
				{
					if ((PI - pi_est.val) < RES)
					{
						done = 1;
					}
				}

#ifdef PRINT_PYTHON
				uint32u_t total;
				total.val = count.total;

				// write byte 0 - 's'
				alt_putchar('s');

				for(int i = 0; i < 4; i++)
				{
					alt_putchar(pi_est.b[i]);
				}

				for(int i = 0; i < 4; i++)
				{
					alt_putchar(total.b[i]);
				}

				// write byte 9 - 't'
				alt_putchar('t');
#endif /* PRINT_PYTHON */

#ifdef PRINT_CURRENT
				alt_putchar('.');
				print_cnt++;
				if (print_cnt > 79)
				{
					print_cnt = 0;
					alt_putstr("\n");
				}
#endif /* PRINT_CURRENT */

				if (1 == done)
				{
#ifdef MEASURE_PERFORMANCE
					PERF_END(PERFMON_BASE, mode);

					perf_print_formatted_report((void *)PERFMON_BASE,
												alt_get_cpu_freq(),
												2, "CIRCLE", "INTEGRAL");
#endif /* MEASURE_PERFORMANCE */

#ifdef PRINT_CURRENT
					alt_putstr("DONE\n");
#endif /* PRINT_CURRENT */
				}
				alt_irq_enable_all(ctxt);
			}
    	}
    }
}
