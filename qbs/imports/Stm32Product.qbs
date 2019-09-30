import qbs

Product {
    Depends { name: "cpp" }
    
    cpp.cLanguageVersion: "c99"

	cpp.driverFlags: [
		"-mcpu=cortex-m4",
		"-mfloat-abi=hard",
		"-mfpu=fpv4-sp-d16",
		"-specs=nosys.specs"
	]
}
