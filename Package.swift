import PackageDescription

let package = Package(name: "SwiftyToolz",
                      products: [.library(name: "SwiftyToolz",
                                          targets: ["SwiftyToolz"])],
                      targets: [.target(name: "SwiftyToolz",
                                        dependencies: [])])
