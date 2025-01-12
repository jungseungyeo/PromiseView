// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "PromiseView",
    platforms: [.iOS(.v15)],
    products: [
        .library(
            name: "PromiseView",
            targets: ["PromiseView"]),
    ],
    targets: [
        .target(
            name: "PromiseView"),
    ]
)
