#ifndef GPIO_H
#define GPIO_H

#ifdef __cplusplus
extern "C" {
#endif

void gpio_init_blue_led(void);
void gpio_toggle_blue_led(void);

#ifdef __cplusplus
}
#endif

#endif // GPIO_H
