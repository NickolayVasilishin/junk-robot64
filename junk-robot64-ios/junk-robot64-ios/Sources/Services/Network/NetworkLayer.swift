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
            let json = JSON(data: data)
            let metrics = json.arrayValue.map { Metric(name: $0["name"].stringValue) }
            DispatchQueue.main.async {
                completion?(metrics)
            }
        }
        .resume()
    }

}
