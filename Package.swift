// swift-tools-version:5.4.0

import PackageDescription

let package = Package(
    name: "SwiftyToolz",
    products: [
        .library(
            name: "SwiftyToolz",
            targets: ["SwiftyToolz"]
        ),
    ],
    targets: [
        .target(
            name: "SwiftyToolz",
            path: "Code"
        ),
    ]
)
