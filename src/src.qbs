import qbs

CppApplication {

    Depends { name: "cpp" }
    Depends { name: "Libraries" }

    condition: {
        if (!qbs.architecture.contains("arm"))
            return false;
        return qbs.toolchain.contains("gcc")
    }
    name: "src"
    cpp.cLanguageVersion: "c99"
    cpp.positionIndependentCode: false

    Properties {
        condition: qbs.toolchain.contains("gcc")
        cpp.driverFlags: [
            "-mcpu=cortex-m4",
            "-mfloat-abi=hard",
            "-mfpu=fpv4-sp-d16",
            "-specs=nosys.specs"
        ]
    }

//	Group {
//		condition: qbs.toolchain.contains("gcc")
//		prefix: "gcc/"
//		name: "Startup"
//		fileTags: ["asm"]
//		files: ["startup.s"]
//	}
	Group {
		condition: qbs.toolchain.contains("gcc")
		prefix: "gcc/"
		name: "Linker Script"
		fileTags: ["linkerscript"]
//		files: ["flash.ld"]
		files: ["stm32F_flash_ROAarray.ld"]
	}

    Group {
        name: "Gpio"
        files: ["gpio.c", "gpio.h"]
    }

    Group {
        name: "System"
        files: ["system.h"]
    }

    files: ["main.c"]
}
