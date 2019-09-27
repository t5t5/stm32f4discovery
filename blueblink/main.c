#include "gpio.h"

#include <stdint.h>

static void some_delay(uint32_t counts)
{
    for (uint32_t index = 0u; index < counts; ++index)
        __asm("nop");
}

int main(void)
{
    gpio_init_blue_led();

    while (1) {
        gpio_toggle_blue_led();
        some_delay(100000u);
    }
}
