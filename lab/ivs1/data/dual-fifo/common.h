/**
 * @file common.h
 * @brief Common definitions
 *
 * @date 2017
 */

#ifndef COMMON_H_
#define COMMON_H_

/**
 * @brief Correction factor for Q1.14 fixed-point multiplication
 */
#define K    (1 << 13)

/**
 * Data union which holds 16 bit value so it can be accessed on a byte boundary
 */
typedef union DATA_UNION {
    uint16_t d;
    uint8_t b[2];
} data_t;

#endif /* COMMON_H_ */
