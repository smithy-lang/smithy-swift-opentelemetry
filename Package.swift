// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "smithy-swift-opentelemetry",
    platforms: [
        .macOS(.v12),
        .iOS(.v16),
        .tvOS(.v16),
        .watchOS(.v9),
    ],
    products: [
        .library(name: "SmithyOpenTelemetry", targets: ["SmithyOpenTelemetry"]),
    ],
    dependencies: [
        .package(url: "https://github.com/smithy-lang/smithy-swift", from: "0.153.0"),
        .package(url: "https://github.com/open-telemetry/opentelemetry-swift", from: "1.13.0"),
    ],
    targets: [
        .target(
            name: "SmithyOpenTelemetry",
            dependencies: [
                .product(name: "Smithy", package: "smithy-swift"),
                .product(name: "SmithyTelemetryAPI", package: "smithy-swift"),
                .product(name: "OpenTelemetryApi", package: "opentelemetry-swift"),
                .product(name: "OpenTelemetrySdk", package: "opentelemetry-swift"),
            ]
        ),
        .testTarget(
            name: "SmithyOpenTelemetryTests",
            dependencies: [
                "SmithyOpenTelemetry",
                .product(name: "Smithy", package: "smithy-swift"),
                .product(name: "SmithyTelemetryAPI", package: "smithy-swift"),
                .product(name: "OpenTelemetryApi", package: "opentelemetry-swift"),
                .product(name: "OpenTelemetrySdk", package: "opentelemetry-swift"),
                .product(name: "InMemoryExporter", package: "opentelemetry-swift"),
            ]
        ),
    ]
)
