#include "gpio.h"
#include "system.h"

#define GPIO_BLUE_LED_PIN_POS   (15u)
#define GPIO_BLUE_LED_PIN       (1u << GPIO_BLUE_LED_PIN_POS)

// Output push pull mode.
#define GPIO_MODE_OUTPUT_PP     (0x00000001u)

// Bit definition for RCC_AHB1ENR register.
#define RCC_AHB1ENR_GPIODEN     (0x00000008u)
// Bits definition for GPIO_MODER register.
#define GPIO_MODER_MODE0        (0x00000003u)

void gpio_init_blue_led(void)
{
    // Enable RCC clock on GPIOD port.
    RCC_REGS_MAP->AHB1ENR |= RCC_AHB1ENR_GPIODEN;
    // Configure GPIO pin #15 as an output.
    uint32_t value = GPIOD_REGS_MAP->MODER;
    value &= ~(GPIO_MODER_MODE0 << (GPIO_BLUE_LED_PIN_POS * 2u));
    value |= (GPIO_MODE_OUTPUT_PP << (GPIO_BLUE_LED_PIN_POS * 2u));
    GPIOD_REGS_MAP->MODER = value;
}

void gpio_toggle_blue_led(void)
{
    GPIOD_REGS_MAP->ODR ^= GPIO_BLUE_LED_PIN;
}
