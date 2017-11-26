import Foundation
import SwiftyJSON

final class NetworkLayer {

    class func getMetrics(completion: (([Metric]?) -> Void)?) {
        URLSession.shared.dataTask(with: Endpoints.metrics) { data, _, _ in
            guard let data = data else {
                DispatchQueue.main.async {
                    completion?(nil)
                }
                return
            }
            let metrics = self.mapMetrics(from: JSON(data: data))
            DispatchQueue.main.async {
                completion?(metrics)
            }
        }
        .resume()
    }

}

private extension NetworkLayer {
    
    class func mapMetrics(from json: JSON) -> [Metric] {
        return json.arrayValue
            .map { rawMetrics in
                Metric(name: rawMetrics["name"].stringValue,
                       reference: Reference(max: rawMetrics["reference_max"].doubleValue,
                                            min: rawMetrics["reference_min"].doubleValue),
                       dataset: rawMetrics["data"].arrayValue
                        .map {
                            MetricData(timestamp: $0[0].doubleValue,
                                       value: $0[1].doubleValue)
                        },
                       unit: rawMetrics["unit"].stringValue)
                
            }
    }

}
