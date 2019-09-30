#include "stm32f4xx.h"

static void delay(uint32_t counts);

int main()
{
    GPIO_InitTypeDef  GPIO_InitStructure;

    /* Enable the SHUTDOWN/PC13 Clock */
    RCC_AHB1PeriphClockCmd(RCC_AHB1Periph_GPIOD, ENABLE);

    /* Configure the GPIO_LED pin */
    GPIO_InitStructure.GPIO_Pin = GPIO_Pin_12 | GPIO_Pin_13;
    GPIO_InitStructure.GPIO_Mode = GPIO_Mode_OUT;
    GPIO_InitStructure.GPIO_OType = GPIO_OType_PP;
    GPIO_InitStructure.GPIO_Speed = GPIO_Speed_25MHz;
    GPIO_InitStructure.GPIO_PuPd = GPIO_PuPd_NOPULL;
    GPIO_Init(GPIOD, &GPIO_InitStructure);

    /* Enable the SHUTDOWN/PC13 Clock */
    GPIO_SetBits(GPIOD,GPIO_Pin_13);
    GPIO_ResetBits(GPIOD,GPIO_Pin_12);

    while (1)
    {
		GPIO_ToggleBits(GPIOD,GPIO_Pin_12);
        delay(100000u);
    }
}

static void delay(uint32_t counts)
{
    for (uint32_t index = 0u; index < counts; ++index)
        __asm("nop");
}
