// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "VideoGameAPI",
    platforms: [.iOS(.v13)],
    products: [
        .library(
            name: "VideoGameAPI",
            targets: ["VideoGameAPI"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "VideoGameAPI",
            dependencies: [])
    ]
)
