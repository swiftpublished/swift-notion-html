// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "swift-notion-html",
    platforms: [
        .macOS(.v13)
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "NotionHTML",
            targets: ["NotionHTML"]
        )
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "NotionHTML",
            dependencies: [
                "HTMLDSL",
                .product(name: "NotionParsing", package: "swift-notion-parsing")
            ],
            path: "Sources/HTML"
        ),
        .testTarget(
            name: "NotionHtmlTests",
            dependencies: [
                "NotionHTML",
                .product(name: "NotionParsingTestHelpers", package: "swift-notion-parsing")
            ],
            path: "Tests/HTMLTests"
        )
    ]
)

/// Local Development Setup
/// 
/// We can set `CI_ENVIRONMENT` in `fly.io` to fetch from Remote
if ProcessInfo.processInfo.environment["CI_ENVIRONMENT"] == "YES" {
    package.dependencies += [
        // 📃 A HTML page renderer for shahrukh's article website
        .package(url: "https://github.com/shahrukhalam/HTMLDSL", branch: "main"),
        .package(url: "https://github.com/swiftpublished/swift-notion-parsing.git", branch: "main")
    ]
} else {
    package.dependencies += [
        .package(path: "../HTMLDSL"),
        .package(path: "../swift-notion-parsing")
    ]
}
