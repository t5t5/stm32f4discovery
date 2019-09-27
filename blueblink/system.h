#ifndef SYSTEM_H
#define SYSTEM_H

#include <stdint.h>

#ifdef __cplusplus
extern "C" {
#endif

#define __IO  volatile

// General purpose input/output registers map.
struct gpio_regs_map {
    __IO uint32_t MODER;
    __IO uint32_t OTYPER;
    __IO uint32_t OSPEEDR;
    __IO uint32_t PUPDR;
    __IO uint32_t IDR;
    __IO uint32_t ODR;
    __IO uint32_t BSRR;
    __IO uint32_t LCKR;
    __IO uint32_t AFR[2u];
};

// Reset and clock control registers map.
struct rcc_regs_map {
    __IO uint32_t CR;
    __IO uint32_t PLLCFGR;
    __IO uint32_t CFGR;
    __IO uint32_t CIR;
    __IO uint32_t AHB1RSTR;
    __IO uint32_t AHB2RSTR;
    __IO uint32_t AHB3RSTR;
    uint32_t      RESERVED0;
    __IO uint32_t APB1RSTR;
    __IO uint32_t APB2RSTR;
    uint32_t      RESERVED1[2u];
    __IO uint32_t AHB1ENR;
    __IO uint32_t AHB2ENR;
    __IO uint32_t AHB3ENR;
    uint32_t      RESERVED2;
    __IO uint32_t APB1ENR;
    __IO uint32_t APB2ENR;
    uint32_t      RESERVED3[2u];
    __IO uint32_t AHB1LPENR;
    __IO uint32_t AHB2LPENR;
    __IO uint32_t AHB3LPENR;
    uint32_t      RESERVED4;
    __IO uint32_t APB1LPENR;
    __IO uint32_t APB2LPENR;
    uint32_t      RESERVED5[2u];
    __IO uint32_t BDCR;
    __IO uint32_t CSR;
    uint32_t      RESERVED6[2u];
    __IO uint32_t SSCGR;
    __IO uint32_t PLLI2SCFGR;
};

#define PERIPH_ADDRESS      (0x40000000u)

#define APB2PERIPH_ADDRESS  (PERIPH_ADDRESS + 0x00010000u)
#define AHB1PERIPH_ADDRESS  (PERIPH_ADDRESS + 0x00020000u)

// APB2 peripherals.
#define SYSCFG_REGS_ADDRESS (APB2PERIPH_ADDRESS + 0x3800u)
#define EXTI_REGS_ADDRESS   (APB2PERIPH_ADDRESS + 0x3C00u)

// AHB1 peripherals.
#define GPIOD_REGS_ADDRESS  (AHB1PERIPH_ADDRESS + 0x0C00u)
#define RCC_REGS_ADDRESS    (AHB1PERIPH_ADDRESS + 0x3800u)

#define GPIOD_REGS_MAP      ((struct gpio_regs_map *)GPIOD_REGS_ADDRESS)
#define RCC_REGS_MAP        ((struct rcc_regs_map *)RCC_REGS_ADDRESS)

#ifdef __cplusplus
}
#endif

#endif // SYSTEM_H
