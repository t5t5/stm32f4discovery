import qbs

Project {
    name: "stm32f4discovery"
    qbsSearchPaths: "qbs"
    references: [
        "libs/libs.qbs",
        "src/src.qbs",
        "other.qbs"
    ]
}
