//
// Copyright Amazon.com Inc. or its affiliates.
// All Rights Reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation
import OpenTelemetrySdk

/// A simple in-memory span exporter for testing purposes.
///
/// `SpanExporter` refines `Sendable`, so the state is guarded by a lock and the
/// conformance is `@unchecked`.
final class InMemoryExporter: SpanExporter, @unchecked Sendable {
    private let lock = NSLock()
    private var finishedSpanItems: [SpanData] = []
    private var isRunning: Bool = true

    func getFinishedSpanItems() -> [SpanData] {
        lock.lock()
        defer { lock.unlock() }
        return finishedSpanItems
    }

    func export(spans: [SpanData], explicitTimeout: TimeInterval? = nil) -> SpanExporterResultCode {
        lock.lock()
        defer { lock.unlock() }
        guard isRunning else { return .failure }
        finishedSpanItems.append(contentsOf: spans)
        return .success
    }

    func flush(explicitTimeout: TimeInterval? = nil) -> SpanExporterResultCode {
        lock.lock()
        defer { lock.unlock() }
        guard isRunning else { return .failure }
        return .success
    }

    func reset() {
        lock.lock()
        defer { lock.unlock() }
        finishedSpanItems.removeAll()
    }

    func shutdown(explicitTimeout: TimeInterval? = nil) {
        lock.lock()
        defer { lock.unlock() }
        finishedSpanItems.removeAll()
        isRunning = false
    }
}
