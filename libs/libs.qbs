import qbs
//import Stm32Library

Product {
    Depends { name: "cpp" }

    name: "Libraries"
    type: "staticlibrary"

    cpp.includePaths: [
        ".",
        "cmsis",
        "device",
        "spl"
    ]

	cpp.driverFlags: [
		"-mcpu=cortex-m4",
		"-mfloat-abi=hard",
		"-mfpu=fpv4-sp-d16",
		"-specs=nosys.specs"
	]

    cpp.defines: [
        "STM32F4XX",
        "STM32F40_41xxx",
        "USE_STDPERIPH_DRIVER",
        "HSE_VALUE=168000000",
    ]

    Properties {
        condition: cpp.debugInformation
        cpp.defines: outer.concat("DEBUG")
    }

    Group {
        name: "cmsis"
        files: [
            "cmsis/*.c",
            "cmsis/*.cpp",
            "cmsis/*.s",
            "cmsis/*.h",
        ]
    }

    Group {
        name: "device"
        files: [
            "device/*.c",
            "device/*.cpp",
            "device/*.s",
            "device/*.h",
        ]
    }

    Group {
        name: "spl"
        files: [
            "spl/*.c",
            "spl/*.cpp",
            "spl/*.s",
            "spl/*.h",
        ]
    }

    Export {
        Depends { name: "cpp" }

        cpp.includePaths: [
            ".",
            "cmsis",
            "device",
            "spl"
        ]
        cpp.defines: [
            "STM32F4XX",
            "STM32F40_41xxx",
            "USE_STDPERIPH_DRIVER",
            "HSE_VALUE=168000000",
        ]

        Properties {
            condition: cpp.debugInformation
            cpp.defines: outer.concat("DEBUG")
        }
    }

}
