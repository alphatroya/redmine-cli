// swift-tools-version:5.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "RedmineCLI",
    platforms: [.macOS(.v10_12)],
    products: [
        .executable(name: "redmine-cli", targets: ["RedmineCLI"]),
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-argument-parser.git", from: "0.3.0"),
        .package(url: "https://github.com/scottrhoyt/SwiftyTextTable", from: "0.9.0"),
        .package(name: "LineNoise", url: "https://github.com/andybest/linenoise-swift", from: "0.0.3"),
    ],
    targets: [
        .target(
            name: "RedmineCLI",
            dependencies: [
                "CBridge",
                "Redmine",
                "TextHighlighter",
                "LineNoise",
                .product(name: "ArgumentParser", package: "swift-argument-parser"),
                "SwiftyTextTable",
            ]
        ),
        .target(
            name: "TextHighlighter",
            dependencies: []
        ),
        .target(
            name: "Redmine",
            dependencies: []
        ),
        .target(
            name: "CBridge",
            dependencies: []
        ),
        .testTarget(
            name: "TextHighlighterTests",
            dependencies: ["TextHighlighter"]
        ),
    ]
)
