//
// Copyright Amazon.com Inc. or its affiliates.
// All Rights Reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

#if os(macOS) || os(iOS) || os(watchOS) || os(tvOS)
import XCTest
@testable import SmithyOpenTelemetry
import OpenTelemetryApi
import Smithy

final class OTelUtilsTests: XCTestCase {
    
    func testEmptyAttributesConversion() {
        let otelAttributes = Attributes().toOtelAttributes()
        
        XCTAssertTrue(otelAttributes.isEmpty)
    }
    
    func testStringAttributeConversion() {
        var attributes = Attributes()
        attributes.set(key: AttributeKey<String>(name: "key"), value: "value")
        
        let otelAttributes = attributes.toOtelAttributes()
        
        guard case .string(let value) = otelAttributes["key"] else {
            return XCTFail("Expected string attribute")
        }
        XCTAssertEqual(value, "value")
    }
    
    func testIntAttributeConversion() {
        var attributes = Attributes()
        attributes.set(key: AttributeKey<Int>(name: "key"), value: 42)
        
        let otelAttributes = attributes.toOtelAttributes()
        
        guard case .int(let value) = otelAttributes["key"] else {
            return XCTFail("Expected int attribute")
        }
        XCTAssertEqual(value, 42)
    }
    
    func testDoubleAttributeConversion() {
        var attributes = Attributes()
        attributes.set(key: AttributeKey<Double>(name: "key"), value: 3.14)
        
        let otelAttributes = attributes.toOtelAttributes()
        
        guard case .double(let value) = otelAttributes["key"] else {
            return XCTFail("Expected double attribute")
        }
        XCTAssertEqual(value, 3.14, accuracy: 0.001)
    }
    
    func testBoolAttributeConversion() {
        var attributes = Attributes()
        attributes.set(key: AttributeKey<Bool>(name: "key"), value: true)
        
        let otelAttributes = attributes.toOtelAttributes()
        
        guard case .bool(let value) = otelAttributes["key"] else {
            return XCTFail("Expected bool attribute")
        }
        XCTAssertTrue(value)
    }
    
    func testStringArrayAttributeConversion() {
        var attributes = Attributes()
        attributes.set(key: AttributeKey<[String]>(name: "key"), value: ["a", "b", "c"])
        
        let otelAttributes = attributes.toOtelAttributes()
        
        guard case .array(let array) = otelAttributes["key"] else {
            return XCTFail("Expected array attribute")
        }
        XCTAssertEqual(array.values.count, 3)
    }
    
    func testIntArrayAttributeConversion() {
        var attributes = Attributes()
        attributes.set(key: AttributeKey<[Int]>(name: "key"), value: [1, 2, 3])
        
        let otelAttributes = attributes.toOtelAttributes()
        
        guard case .array(let array) = otelAttributes["key"] else {
            return XCTFail("Expected array attribute")
        }
        XCTAssertEqual(array.values.count, 3)
    }
    
    func testDoubleArrayAttributeConversion() {
        var attributes = Attributes()
        attributes.set(key: AttributeKey<[Double]>(name: "key"), value: [1.1, 2.2, 3.3])
        
        let otelAttributes = attributes.toOtelAttributes()
        
        guard case .array(let array) = otelAttributes["key"] else {
            return XCTFail("Expected array attribute")
        }
        XCTAssertEqual(array.values.count, 3)
    }
    
    func testBoolArrayAttributeConversion() {
        var attributes = Attributes()
        attributes.set(key: AttributeKey<[Bool]>(name: "key"), value: [true, false, true])
        
        let otelAttributes = attributes.toOtelAttributes()
        
        guard case .array(let array) = otelAttributes["key"] else {
            return XCTFail("Expected array attribute")
        }
        XCTAssertEqual(array.values.count, 3)
    }
    
    func testMultipleAttributesConversion() {
        var attributes = Attributes()
        attributes.set(key: AttributeKey<String>(name: "string-key"), value: "value")
        attributes.set(key: AttributeKey<Int>(name: "int-key"), value: 100)
        attributes.set(key: AttributeKey<Bool>(name: "bool-key"), value: false)
        attributes.set(key: AttributeKey<Double>(name: "double-key"), value: 2.71)
        
        let otelAttributes = attributes.toOtelAttributes()
        
        XCTAssertEqual(otelAttributes.count, 4)

        guard case .string(let stringValue) = otelAttributes["string-key"] else {
            return XCTFail("Expected string attribute")
        }
        XCTAssertEqual(stringValue, "value")

        guard case .int(let intValue) = otelAttributes["int-key"] else {
            return XCTFail("Expected int attribute")
        }
        XCTAssertEqual(intValue, 100)

        guard case .bool(let boolValue) = otelAttributes["bool-key"] else {
            return XCTFail("Expected bool attribute")
        }
        XCTAssertFalse(boolValue)

        guard case .double(let doubleValue) = otelAttributes["double-key"] else {
            return XCTFail("Expected double attribute")
        }
        XCTAssertEqual(doubleValue, 2.71, accuracy: 0.001)
    }
}
#endif
