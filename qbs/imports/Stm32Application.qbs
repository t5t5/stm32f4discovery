import qbs

Stm32Product {
    type: "application" // To suppress bundle generation on Mac
    consoleApplication: true
    
    cpp.executableSuffix: ".elf"

    cpp.positionIndependentCode: false

	Group {
		prefix: "../../ldscripts/"
		name: "Linker Script"
		fileTags: ["linkerscript"]
		files: ["flash.ld"]
	}
}
