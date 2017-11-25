import Foundation
import SwiftyJSON

final class NetworkLayer {

    class func getMetrics(completion: (([Metric]?) -> Void)?) {
        URLSession.shared.dataTask(with: Endpoints.metrics) { data, _, _ in
            guard let data = data else {
                completion?(nil)
                return
            }
            let json = JSON(data: data)
            let metrics = json.arrayValue.map { Metric(name: $0["name"].stringValue) }
            completion?(metrics)
            }
        .resume()
    }

}
