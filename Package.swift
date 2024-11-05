// swift-tools-version: 6.0

import PackageDescription

let package = Package(
    name: "SwiftyToolz",
    products: [
        .library(
            name: "SwiftyToolz",
            targets: ["SwiftyToolz"]
        )
    ],
    targets: [
        .target(
            name: "SwiftyToolz",
            path: "Code"
        ),
        .testTarget(
            name: "SwiftyToolzTests",
            dependencies: ["SwiftyToolz"],
            path: "Tests"
        )
    ]
)
