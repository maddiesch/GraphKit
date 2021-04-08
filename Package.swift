// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "GraphKit",
    platforms: [
        .macOS(.v10_15),
        .iOS(.v13),
        .tvOS(.v13),
        .watchOS(.v6)
    ],
    products: [
        .library(name: "GraphKit", targets: ["GraphKit"]),
    ],
    dependencies: [],
    targets: [
        .target(name: "GraphKit", dependencies: []),
        .testTarget(name: "GraphKitTests", dependencies: ["GraphKit"]),
    ]
)
