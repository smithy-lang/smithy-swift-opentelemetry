## OpenTelemetry Integration for smithy-swift

This project is an optional add-on for [smithy-swift](https://github.com/smithy-lang/smithy-swift) that
integrates OpenTelemetry-compatible monitoring with AWS SDK for Swift and other Smithy-based Swift SDKs.

Currently, only the OpenTelemetry logging and tracing features are supported.  Other OpenTelemetry
features may be added in the future.

### Getting started
1. In your project's `Package.swift`, add this package as a dependency, and add the `SmithyOpenTelemetry`
   library to the application target where you will use your client.

   Add this Swift package as a dependency to your project, along with your SDK.   
```swift
    dependencies: [
        .package(url: "https://github.com/awslabs/aws-sdk-swift", from: "1.0.0"),
        .package(url: "https://github.com/smithy-lang/smithy-swift-opentelemetry", from: "0.0.1")
    ],
```
   Then add the `SmithyOpenTelemetry` library to your application target.
```swift
    targets: [
        .target(
            name: "MyAppTarget",
            dependencies: [
                .product(name: "AWSS3", package: "aws-sdk-swift"), // or any other SDK target
                .product(name: "SmithyOpenTelemetry", package: "smithy-swift-opentelemetry")
            ]
        )
    ]
```
2. When configuring your client, create an `OpenTelemetrySwiftProvider` and set it as your
   client's telemetry provider.
```swift
let openTelemetrySwiftProvider = OpenTelemetrySwiftProvider(
    // configure your logger & tracer here
)

let config = try await S3ClientConfiguration(
    telemetryProvider: openTelemetrySwiftProvider
    // set any other config you desire here as well
)

let s3Client = S3Client(config: config)
```

## Security

See [CONTRIBUTING](CONTRIBUTING.md#security-issue-notifications) for more information.

## License

This project is licensed under the Apache-2.0 License.
