// swift-tools-version:4.2

import PackageDescription

let package = Package(
    name: "SwiftyToolz",
    products: [
        .library(name: "SwiftyToolz",
                 targets: ["SwiftyToolz"]),
    ],
    targets: [
        .target(name: "SwiftyToolz",
                path: "Code"),
    ]
)
