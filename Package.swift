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
    ],
    targets: [
        .target(
            name: "RedmineCLI",
            dependencies: ["CBridge"]
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
