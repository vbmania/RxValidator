// swift-tools-version:4.0
import PackageDescription

let package = Package(
    name: "RxValidator",
    products: [
        .library(name: "RxValidator", targets: ["RxValidator"])
    ],
    dependencies: [
        .package(url: "https://github.com/ReactiveX/RxSwift.git", .upToNextMinor(from: "4.1.0"))
    ],
    targets: [
        .target(
            name: "RxValidator",
            dependencies: ["RxSwift"],
            path: "Sources"
        )
    ],
    swiftLanguageVersions: [4]
)
