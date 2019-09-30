import qbs

Stm32Application {
    Depends { name: "cpp" }
    Depends { name: "Libraries" }

    name: "src"

    files: ["main.c"]
}
