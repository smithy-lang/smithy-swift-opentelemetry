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
import Smithy
import SmithyTelemetryAPI
import InMemoryExporter

final class OTelTracingTests: XCTestCase {
    
    var spanExporter: InMemoryExporter!
    var tracerProvider: OTelTracerProvider!
    
    override func setUp() {
        super.setUp()
        spanExporter = InMemoryExporter()
        tracerProvider = OTelTracerProvider(spanExporter: spanExporter)
    }
    
    override func tearDown() {
        spanExporter.reset()
        spanExporter = nil
        tracerProvider = nil
        super.tearDown()
    }
    
    func testGetTracer() {
        let tracer = tracerProvider.getTracer(scope: "test-scope")
        
        XCTAssertNotNil(tracer)
        XCTAssertTrue(tracer is OTelTracerImpl)
    }
    
    func testCreateSpan() {
        let tracer = tracerProvider.getTracer(scope: "test-scope")
        let span = tracer.createSpan(name: "test-span", initialAttributes: nil, spanKind: .client, parentContext: nil)
        
        XCTAssertEqual(span.name, "test-span")
    }
    
    func testCreateSpanWithAttributes() {
        let tracer = tracerProvider.getTracer(scope: "test-scope")
        var attributes = Attributes()
        attributes.set(key: AttributeKey<String>(name: "key1"), value: "value1")
        
        let span = tracer.createSpan(name: "test-span", initialAttributes: attributes, spanKind: .server, parentContext: nil)
        span.end()
        
        XCTAssertEqual(span.name, "test-span")
    }
    
    func testSpanEmitEvent() {
        let span = tracerProvider.getTracer(scope: "test-scope")
            .createSpan(name: "test-span", initialAttributes: nil, spanKind: .internal, parentContext: nil)
        
        span.emitEvent(name: "test-event", attributes: nil)
        span.end()
        
        // Force flush to ensure spans are exported
        tracerProvider.forceFlush()

        XCTAssertEqual(spanExporter.getFinishedSpanItems().count, 1)
    }
    
    func testSpanEmitEventWithAttributes() {
        let span = tracerProvider.getTracer(scope: "test-scope")
            .createSpan(name: "test-span", initialAttributes: nil, spanKind: .producer, parentContext: nil)
        var eventAttributes = Attributes()
        eventAttributes.set(key: AttributeKey<String>(name: "event-key"), value: "event-value")
        
        span.emitEvent(name: "test-event", attributes: eventAttributes)
        span.end()
        
        // Force flush to ensure spans are exported
        tracerProvider.forceFlush()

        XCTAssertEqual(spanExporter.getFinishedSpanItems().count, 1)
    }
    
    func testSpanSetAttribute() {
        let span = tracerProvider.getTracer(scope: "test-scope")
            .createSpan(name: "test-span", initialAttributes: nil, spanKind: .consumer, parentContext: nil)
        
        span.setAttribute(key: AttributeKey<String>(name: "runtime-key"), value: "runtime-value")
        span.end()
        
        // Force flush to ensure spans are exported
        tracerProvider.forceFlush()

        XCTAssertEqual(spanExporter.getFinishedSpanItems().count, 1)
    }
    
    func testSpanSetStatus() {
        let span = tracerProvider.getTracer(scope: "test-scope")
            .createSpan(name: "test-span", initialAttributes: nil, spanKind: .client, parentContext: nil)
        
        span.setStatus(status: .ok)
        span.end()
        
        // Force flush to ensure spans are exported
        tracerProvider.forceFlush()

        XCTAssertEqual(spanExporter.getFinishedSpanItems().count, 1)
    }
    
    func testSpanKindConversion() {
        XCTAssertEqual(SpanKind.client.toOTelSpanKind(), .client)
        XCTAssertEqual(SpanKind.server.toOTelSpanKind(), .server)
        XCTAssertEqual(SpanKind.producer.toOTelSpanKind(), .producer)
        XCTAssertEqual(SpanKind.consumer.toOTelSpanKind(), .consumer)
        XCTAssertEqual(SpanKind.internal.toOTelSpanKind(), .internal)
    }
    
    func testTraceSpanStatusConversion() {
        XCTAssertEqual(TraceSpanStatus.ok.toOTelStatus(), .ok)
        XCTAssertNotEqual(TraceSpanStatus.error.toOTelStatus(), .ok)
        XCTAssertEqual(TraceSpanStatus.unset.toOTelStatus(), .unset)
    }
}
#endif
