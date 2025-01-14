// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "UITestsHelper",
    platforms: [
          .iOS(.v15) // adjust minimum version as needed
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "UITestsHelper",
            targets: ["UITestsHelper"]),
        .library(
            name: "UITestsHelperConfigurator",
            targets: ["UITestsHelperConfigurator"]),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "UITestsHelper"),
        .target(name: "UITestsHelperConfigurator",
                sources: ["UITestHelperConfigurator.swift"])

    ]
)
