// swift-tools-version:6.2
import PackageDescription

let package = Package(
    name: "OnboardKit",
    platforms: [.iOS(.v15)],
    products: [
        .library(name: "OnboardKit",  targets: ["OnboardKit"]),
    ],
    targets: [
        .target(name: "OnboardKit",
                path: "OnboardKit",
                swiftSettings: [
                    .swiftLanguageMode(.v6),
                ]),
    ]
)
