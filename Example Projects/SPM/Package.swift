// swift-tools-version:4.2

import PackageDescription

let package = Package(
    name: "SPM",
    dependencies: [
        .package(url: "https://github.com/flowtoolz/SwiftyToolz.git",
                 .upToNextMajor(from: "1.4.3"))
        //.package(path: "../../../SwiftyToolz")
    ],
    targets: [
        .target(name: "SPM", dependencies: ["SwiftyToolz"])
    ],
    swiftLanguageVersions: [.v4_2]
)
