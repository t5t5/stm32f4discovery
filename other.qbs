import qbs

Product {
    Group {
        name: "ldscripts"
		fileTags: "other"
        files: "ldscripts/*"
    }
    Group {
        name: "qbs-import"
		fileTags: "other"
        files: "qbs/**"
    }
}
