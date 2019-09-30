/* Entry point (defined in assembled file). */
ENTRY(reset_handler)

/* End of RAM, it is the user mode stack pointer address. */
_end_of_stack = 0x20020000;

/* Generate a link error if heap and stack don't fit into RAM. */
_size_of_heap = 0x200;  /* Required amount of heap. */
_size_of_stack = 0x400; /* Required amount of stack. */

MEMORY {
    RAM (xrw)   : ORIGIN = 0x20000000, LENGTH = 128K
    CCMRAM (rw) : ORIGIN = 0x10000000, LENGTH = 64K
    FLASH (rx)  : ORIGIN = 0x8000000, LENGTH = 1024K
}

SECTIONS {
    /* The vectors table goes into FLASH. */
    .isr_vector : {
        . = ALIGN(4);
        KEEP(*(.isr_vector)) /* Startup code. */
        . = ALIGN(4);
    } > FLASH

    /* The program code and other data goes into FLASH. */
    .text : {
        . = ALIGN(4);
        *(.text)
        *(.text*)
        *(.glue_7)                    /* Glue arm to thumb code. */
        *(.glue_7t)                   /* Glue thumb to arm code. */
        *(.eh_frame)
        KEEP(*(.init))
        KEEP(*(.fini))
        . = ALIGN(4);
        _end_of_text_section = .;     /* Export global symbol at end of code. */
    } > FLASH

    /* Constant data goes into FLASH. */
    .rodata : {
        . = ALIGN(4);
        *(.rodata)
        *(.rodata*)
        . = ALIGN(4);
    } > FLASH

    .ARM.extab : {
        *(.ARM.extab* .gnu.linkonce.armextab.*)
    } > FLASH

    .ARM : {
        __exidx_start = .;
        *(.ARM.exidx*)
        __exidx_end = .;
    } > FLASH

    .preinit_array : {
        PROVIDE_HIDDEN(__preinit_array_start = .);
        KEEP(*(.preinit_array*))
        PROVIDE_HIDDEN(__preinit_array_end = .);
    } > FLASH

    .init_array : {
        PROVIDE_HIDDEN(__init_array_start = .);
        KEEP(*(SORT(.init_array.*)))
        KEEP(*(.init_array*))
        PROVIDE_HIDDEN(__init_array_end = .);
    } > FLASH

    .fini_array : {
        PROVIDE_HIDDEN(__fini_array_start = .);
        KEEP(*(SORT(.fini_array.*)))
        KEEP(*(.fini_array*))
        PROVIDE_HIDDEN(__fini_array_end = .);
    } > FLASH

    _start_of_init_data_section = LOADADDR(.data);

    /* Initialized data sections goes into RAM, load LMA copy after code. */
    .data : {
        . = ALIGN(4);
        _start_of_data_section = .;   /* Export global symbol at data start. */
        *(.data)
        *(.data*)
        . = ALIGN(4);
        _end_of_data_section = .;     /* Export global symbol at data end. */
    } > RAM AT > FLASH

    _start_of_iccm_ram_section = LOADADDR(.ccmram);

    /* CCM-RAM section. */
    .ccmram : {
        . = ALIGN(4);
        _start_of_ccmram_section = .; /* Export global symbol at ccmram start. */
        *(.ccmram)
        *(.ccmram*)
        . = ALIGN(4);
        _end_of_ccmram_section = .;   /* Export global symbol at ccmram end. */
    } > CCMRAM AT > FLASH

    /* Uninitialized data section. */
    . = ALIGN(4);
    .bss : {
        /* This is used by the startup in order to initialize the .bss secion. */
        _start_of_bss_section = .;    /* Export global symbol at bss start. */
        __bss_start__ = _start_of_bss_section;
        *(.bss)
        *(.bss*)
        *(COMMON)
        . = ALIGN(4);
        _end_of_bss_section = .;      /* Export global symbol at bss end. */
        __bss_end__ = _end_of_bss_section;
    } > RAM

    /* Used to check that there is enough RAM left. */
    ._user_heap_stack : {
        . = ALIGN(4);
        PROVIDE(end = .);
        PROVIDE(_end = .);
        . = . + _size_of_heap;
        . = . + _size_of_stack;
        . = ALIGN(4);
    } > RAM

    /* Remove information from the standard libraries. */
    /DISCARD/ : {
        libc.a ( * )
        libm.a ( * )
        libgcc.a ( * )
    }

    .ARM.attributes 0 : {
        *(.ARM.attributes)
    }
}
