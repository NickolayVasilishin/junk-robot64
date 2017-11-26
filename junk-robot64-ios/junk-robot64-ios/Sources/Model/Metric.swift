import Foundation

struct Metric {
    let name: String
    let reference: Reference
    let dataset: [MetricData]
    let unit: String
}
