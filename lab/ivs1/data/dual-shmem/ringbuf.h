/**
 * @file ringbuf.h
 * @date 2017
 */

#ifndef RINGBUF_H_
#define RINGBUF_H_

#include <stdint.h>

/**
 * Data union which holds 32bit value so it can be accessed on a byte boundary
 */
typedef union DATA_UNION {
    uint16_t d;
    uint8_t b[2];
} data_t;

/**
 * Structure of item that is used in ring buffer
 */
typedef struct {
	data_t zero;    // this needs to be initialized to 0
    data_t data1;
    data_t data2;
    data_t result;
} item_t;

/**
 * @brief Initialize ring buffer
 * @param writer Used to signal if caller writes to buffer or reads from it
 */
extern void ringbuf_init(uint32_t writer);

/**
 * @brief Enqueue data to buffer
 * @param data Data to enqueue
 */
extern uint32_t ringbuf_enqueue(item_t data);

/**
 * @brief Dequeue data from buffer
 * @param data Data buffer where read data is saved
 */
extern uint32_t ringbuf_dequeue(item_t *data);

#endif /* RINGBUF_H_ */
