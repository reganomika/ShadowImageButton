// swift-tools-version:5.7
import PackageDescription

let package = Package(
    name: "ShadowImageButton",
    platforms: [
        .iOS(.v13)
    ],
    products: [
        .library(
            name: "ShadowImageButton",
            targets: ["ShadowImageButton"]),
    ],
    dependencies: [
        .package(url: "https://github.com/SnapKit/SnapKit.git", from: "5.6.0")
    ],
    targets: [
        .target(
            name: "ShadowImageButton",
            dependencies: ["SnapKit"],
            path: "Sources/ShadowImageButton"),
        .testTarget(
            name: "ShadowImageButtonTests",
            dependencies: ["ShadowImageButton"],
            path: "Tests/ShadowImageButtonTests"),
    ]
)
