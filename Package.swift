// swift-tools-version: 5.10

import PackageDescription

let package = Package(
    name: "smithy-swift-opentelemetry",
    platforms: [
        .macOS(.v12),
        .iOS(.v13),
        .tvOS(.v13),
        .watchOS(.v9),
    ],
    products: [
        .library(name: "SmithyOpenTelemetry", targets: ["SmithyOpenTelemetry"]),
    ],
    dependencies: [
        .package(url: "https://github.com/smithy-lang/smithy-swift", from: "0.191.0"),
        .package(url: "https://github.com/open-telemetry/opentelemetry-swift-core", from: "2.3.0"),
    ],
    targets: [
        .target(
            name: "SmithyOpenTelemetry",
            dependencies: [
                .product(name: "Smithy", package: "smithy-swift"),
                .product(name: "SmithyTelemetryAPI", package: "smithy-swift"),
                .product(name: "OpenTelemetryApi", package: "opentelemetry-swift-core"),
                .product(name: "OpenTelemetrySdk", package: "opentelemetry-swift-core"),
            ]
        ),
        .testTarget(
            name: "SmithyOpenTelemetryTests",
            dependencies: [
                "SmithyOpenTelemetry",
                .product(name: "Smithy", package: "smithy-swift"),
                .product(name: "SmithyTelemetryAPI", package: "smithy-swift"),
                .product(name: "OpenTelemetryApi", package: "opentelemetry-swift-core"),
                .product(name: "OpenTelemetrySdk", package: "opentelemetry-swift-core"),
            ]
        ),
    ]
)
