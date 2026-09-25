// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "zo_screenshot",
    platforms: [
        .iOS("12.0")
    ],
    products: [
        .library(name: "zo-screenshot", targets: ["zo_screenshot"])
    ],
    dependencies: [
        .package(name: "FlutterFramework", path: "../FlutterFramework"),
        .package(url: "https://github.com/prongbang/ScreenProtectorKit.git", from: "1.5.2")
    ],
    targets: [
        .target(
            name: "zo_screenshot",
            dependencies: [
                .product(name: "FlutterFramework", package: "FlutterFramework"),
                .product(name: "ScreenProtectorKit", package: "ScreenProtectorKit")
            ],
            resources: []
        )
    ]
)


// https://blog.stackademic.com/flutters-swift-package-manager-migration-is-here-and-if-you-maintain-a-plugin-you-need-to-read-d23ffc088164