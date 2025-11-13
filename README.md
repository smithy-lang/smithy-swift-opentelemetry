## OpenTelemetry Integration for smithy-swift

This project is an optional add-on for [smithy-swift](https://github.com/smithy-lang/smithy-swift) that
integrates OpenTelemetry-compatible monitoring with AWS SDK for Swift and other Smithy-based Swift SDKs.

To use:
1. Add this project as a dependency to your project, along with your SDK.
```swift
    dependencies: [
        .package(url: "https://github.com/awslabs/aws-sdk-swift", from: "1.0.0"),
        .package(url: "https://github.com/smithy-lang/smithy-swift-opentelemetry", from: "0.0.1")
    ],
```
2. 

## Security

See [CONTRIBUTING](CONTRIBUTING.md#security-issue-notifications) for more information.

## License

This project is licensed under the Apache-2.0 License.
