// swift-tools-version:4.0
import PackageDescription

let package = Package(
    name: "RxValidator",
    products: [
        .library(name: "RxValidator", targets: ["RxValidator"])
    ],
    dependencies: [
        .package(url: "https://github.com/ReactiveX/RxSwift.git", .upToNextMinor(from: "4.1.0")),

        .package(url: "https://github.com/Quick/Quick.git", from: "1.3.1"),
        .package(url: "https://github.com/Quick/Nimble.git", from: "7.3.0"),
        .package(url: "https://github.com/malcommac/SwiftDate", from: "5.0.9")
    ],
    targets: [
        .target(
            name: "RxValidator",
            dependencies: ["RxSwift"],
            path: "Sources"
        ),
        .testTarget(
            name: "RxValidatorTests",
            dependencies: [
                "RxValidator",
                "RxCocoa",
                "RxSwift",
                "Quick",
                "Nimble",
                "SwiftDate"
            ],
            path: "Tests"
        )
    ],
    swiftLanguageVersions: [4]
)
