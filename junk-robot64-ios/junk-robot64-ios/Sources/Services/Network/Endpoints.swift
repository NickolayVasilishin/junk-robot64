import Foundation

struct Endpoints {

    private struct Constants {
        static let scheme = "http"
        static let baseURL = "10.100.31.96:9999"
    }

    static func makeURL(endpoint: String) -> URL {
        return URL(string: Constants.scheme + "://" + Constants.baseURL + "/" + endpoint)!
    }

    // MARK: Endpoints

    static var metrics: URL {
        return self.makeURL(endpoint: "metrics")
    }

}
