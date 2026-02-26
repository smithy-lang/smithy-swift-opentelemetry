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

This package depends on [opentelemetry-swift-core](https://github.com/open-telemetry/opentelemetry-swift-core) for the `OpenTelemetryApi` and `OpenTelemetrySdk` modules.

### Usage

```swift
import SmithyOpenTelemetry
import OpenTelemetrySdk

// Create a span exporter (use any SpanExporter implementation)
let spanExporter = YourSpanExporter()

// Create the OpenTelemetry telemetry provider
let telemetryProvider = OpenTelemetrySwift.provider(spanExporter: spanExporter)

// Use with any smithy-swift based client (e.g., AWS SDK for Swift)
let config = try await YourClient.YourClientConfiguration(
    region: "us-west-2",
    telemetryProvider: telemetryProvider
)

let client = YourClient(config: config)
```

For span exporters, you can use any `SpanExporter` implementation from the OpenTelemetry ecosystem, such as the OTLP exporters from the [opentelemetry-swift](https://github.com/open-telemetry/opentelemetry-swift) package.

## Security

See [CONTRIBUTING](CONTRIBUTING.md#security-issue-notifications) for more information.

## License

This project is licensed under the Apache-2.0 License.