/**
 * @file ringbuf.c
 * @date 2017
 *
 * Ring buffer implementation.
 * Bit 31 is used for cache bypass.
 */

#include "ringbuf.h"
#include <system.h>

#define RINGBUF_PBUF_OFFSET             (0x00)
#define RINGBUF_PHEAD_OFFSET            (0x04)
#define RINGBUF_PTAIL_OFFSET            (0x08)
#define RINGBUF_PEND_OFFSET             (0x0C)
#define RINGBUF_PCOUNT_OFFSET           (0x10)
#define RINGBUF_PMAX_COUNT_OFFSET       (0x14)

#define RINGBUF_START_OFFSET            (0x20)

/*
 * 0x80000000 is added to set bit 31 so data cache is bypassed when accessing
 * Ring buffer data
 */
#define RINGBUF_BASE                    (SHARED_MEM_BASE + 0x80000000)
#define RINGBUF_SPAN                    (SHARED_MEM_SPAN)

#define RINGBUF_PBUF_ADDR               (RINGBUF_BASE + RINGBUF_PBUF_OFFSET)
#define RINGBUF_PHEAD_ADDR              (RINGBUF_BASE + RINGBUF_PHEAD_OFFSET)
#define RINGBUF_PTAIL_ADDR              (RINGBUF_BASE + RINGBUF_PTAIL_OFFSET)
#define RINGBUF_PEND_ADDR               (RINGBUF_BASE + RINGBUF_PEND_OFFSET)
#define RINGBUF_PCOUNT_ADDR             (RINGBUF_BASE + RINGBUF_PCOUNT_OFFSET)
#define RINGBUF_PMAX_COUNT_ADDR         (RINGBUF_BASE + RINGBUF_PMAX_COUNT_OFFSET)
#define RINGBUF_START_ADDR              (RINGBUF_BASE + RINGBUF_START_OFFSET)
#define RINGBUF_END_ADDR                (RINGBUF_BASE + RINGBUF_SPAN)
#define RINGBUF_MAX_COUNT               ((RINGBUF_SPAN - RINGBUF_START_OFFSET) / 8)

/**
 * Main ringbuffer structure
 */
typedef struct {
    item_t **pBuffer;
    item_t * volatile *pHead;
    item_t * volatile *pTail;
    item_t **pEnd;
    uint32_t volatile *count;
    uint32_t *maxCount;
} RingBuffer_t;

/**
 * Data which holds pointers to Ringbuffer
 */
volatile RingBuffer_t shared_buffer = { 0 };

/**
 * @brief Initialize ring buffer
 * @param writer Used to signal if caller writes to buffer or reads from it
 */
void ringbuf_init(uint32_t writer)
{
    shared_buffer.pBuffer = (item_t **)RINGBUF_PBUF_ADDR;
    shared_buffer.pHead = (item_t **)RINGBUF_PHEAD_ADDR;
    shared_buffer.pTail = (item_t **)RINGBUF_PTAIL_ADDR;
    shared_buffer.pEnd = (item_t **)RINGBUF_PEND_ADDR;
    shared_buffer.count = (uint32_t *)RINGBUF_PCOUNT_ADDR;
    shared_buffer.maxCount = (uint32_t *)RINGBUF_PMAX_COUNT_ADDR;

    if (writer == 1)
    {
        *(shared_buffer.pBuffer) = (item_t *)RINGBUF_START_ADDR;
        *(shared_buffer.pHead) = (item_t *)RINGBUF_START_ADDR;
        *(shared_buffer.pTail) = (item_t *)RINGBUF_START_ADDR;
        *(shared_buffer.pEnd) = (item_t *)RINGBUF_END_ADDR - 1;
        *(shared_buffer.count) = 0;
        *(shared_buffer.maxCount) = RINGBUF_MAX_COUNT;
    }
}

/**
 * @brief Enqueue data to buffer
 * @param data Data to enqueue
 */
uint32_t ringbuf_enqueue(item_t data)
{
    // store data
    **(shared_buffer.pHead) = data;

    // update Head pointer
    if (*(shared_buffer.pHead) == *(shared_buffer.pEnd))
    {
        *(shared_buffer.pHead) = *(shared_buffer.pBuffer);
    }
    else
    {
        (*(shared_buffer.pHead))++;
    }

    // update data count
    if ((*(shared_buffer.count) + 1) <= *(shared_buffer.maxCount))
    {
        (*(shared_buffer.count))++;
    }

    return 0;
}

/**
 * @brief Dequeue data from buffer
 * @param data Data buffer where read data is saved
 */
uint32_t ringbuf_dequeue(item_t *data)
{
    // check if buffer is empty
    if ((*(shared_buffer.pHead) == *(shared_buffer.pTail)) && (*(shared_buffer.count) == 0))
    {
        return 1;
    }
    else
    {
        // if there is data, read it
        *data = **(shared_buffer.pTail);

        // update Tail pointer
        if (*(shared_buffer.pTail) == *(shared_buffer.pEnd))
        {
            *(shared_buffer.pTail) = *(shared_buffer.pBuffer);
        }
        else
        {
            (*(shared_buffer.pTail))++;
        }

        // update data count
        if (*(shared_buffer.count) > 0)
        {
            (*(shared_buffer.count))--;
        }
    }

    return 0;
}
