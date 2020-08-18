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
        .package(url: "https://github.com/apple/swift-argument-parser.git", from: "0.2.1"),
        .package(url: "https://github.com/scottrhoyt/SwiftyTextTable", from: "0.9.0"),
    ],
    targets: [
        .target(
            name: "RedmineCLI",
            dependencies: [
                "CBridge",
                "Redmine",
                .product(name: "ArgumentParser", package: "swift-argument-parser"),
                "SwiftyTextTable",
            ]
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
            name: "RedmineCLITests",
            dependencies: ["RedmineCLI"]
        ),
    ]
)
