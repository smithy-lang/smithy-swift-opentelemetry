//
// Copyright Amazon.com Inc. or its affiliates.
// All Rights Reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation
import OpenTelemetrySdk

/// A simple in-memory span exporter for testing purposes.
class InMemoryExporter: SpanExporter {
    private var finishedSpanItems: [SpanData] = []
    private var isRunning: Bool = true

    func getFinishedSpanItems() -> [SpanData] {
        return finishedSpanItems
    }

    func export(spans: [SpanData], explicitTimeout: TimeInterval? = nil) -> SpanExporterResultCode {
        guard isRunning else { return .failure }
        finishedSpanItems.append(contentsOf: spans)
        return .success
    }

    func flush(explicitTimeout: TimeInterval? = nil) -> SpanExporterResultCode {
        guard isRunning else { return .failure }
        return .success
    }

    func reset() {
        finishedSpanItems.removeAll()
    }

    func shutdown(explicitTimeout: TimeInterval? = nil) {
        finishedSpanItems.removeAll()
        isRunning = false
    }
}
