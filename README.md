## Smithy Swift OpenTelemetry

This package provides OpenTelemetry integration for smithy-swift clients. It bridges the Smithy telemetry API with the OpenTelemetry Swift SDK, allowing you to export traces and metrics.

### Features

- OpenTelemetry tracer provider implementation
- Span creation and management
- Attribute conversion between Smithy and OpenTelemetry formats
- Platform support for macOS, iOS, tvOS, and watchOS

### Installation

Add this package as a dependency when you need OpenTelemetry support for your Smithy Swift clients:

```swift
dependencies: [
    .package(url: "https://github.com/smithy-lang/smithy-swift-opentelemetry", from: "1.0.0"),
]
```

### Usage

```swift
import SmithyOpenTelemetry
import InMemoryExporter  // Add the exporter you need

// Create a span exporter
let spanExporter = InMemoryExporter()

// Create the OpenTelemetry telemetry provider
let telemetryProvider = OpenTelemetrySwift.provider(spanExporter: spanExporter)

// Use with any smithy-swift based client (e.g., AWS SDK for Swift)
let config = try await YourClient.YourClientConfiguration(
    region: "us-west-2",
    telemetryProvider: telemetryProvider
)

let client = YourClient(config: config)
```

You'll need to add the exporter package to your dependencies:
```swift
.product(name: "InMemoryExporter", package: "opentelemetry-swift")
```

## Security

See [CONTRIBUTING](CONTRIBUTING.md#security-issue-notifications) for more information.

## License

This project is licensed under the Apache-2.0 License.