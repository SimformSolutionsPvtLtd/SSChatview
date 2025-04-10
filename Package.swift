// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SSChatview",
    defaultLocalization: "en",
    platforms: [
        .iOS(.v16)
    ],
    products: [
        .library(
            name: "SSChatview",
            targets: ["SSChatview"]
        )
    ],
    dependencies: [
        // Add package dependencies here if needed
    ],
    targets: [
        .target(
            name: "SSChatview",
            dependencies: [],
            resources: [
                .process("Resources")
            ],
            swiftSettings: [
                .define("SPM")
            ]
        )
    ],
    swiftLanguageModes: [.v5]
)
