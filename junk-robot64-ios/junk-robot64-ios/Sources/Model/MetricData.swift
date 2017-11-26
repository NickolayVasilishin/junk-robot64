import Foundation

struct MetricData {
    let date: Date
    let value: Double

    init(timestamp: Double, value: Double) {
        self.date = Date(timeIntervalSince1970: timestamp)
        self.value = value
    }
}
