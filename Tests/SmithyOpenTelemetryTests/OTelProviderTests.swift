//
// Copyright Amazon.com Inc. or its affiliates.
// All Rights Reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

#if os(macOS) || os(iOS) || os(watchOS) || os(tvOS)
import XCTest
@testable import SmithyOpenTelemetry
import OpenTelemetrySdk

final class OTelProviderTests: XCTestCase {
    
    func testProviderCreation() {
        let provider = OpenTelemetrySwift.provider(spanExporter: InMemoryExporter())
        
        XCTAssertNotNil(provider.contextManager)
        XCTAssertNotNil(provider.loggerProvider)
        XCTAssertNotNil(provider.meterProvider)
        XCTAssertNotNil(provider.tracerProvider)
    }
    
    func testOpenTelemetrySwiftProviderInitialization() {
        let provider = OpenTelemetrySwift.OpenTelemetrySwiftProvider(spanExporter: InMemoryExporter())
        
        XCTAssertNotNil(provider.contextManager)
        XCTAssertNotNil(provider.loggerProvider)
        XCTAssertNotNil(provider.meterProvider)
        XCTAssertTrue(provider.tracerProvider is OTelTracerProvider)
    }
}
#endif
