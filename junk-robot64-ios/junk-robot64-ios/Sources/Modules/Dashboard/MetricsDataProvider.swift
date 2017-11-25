import UIKit

final class MetricsDataProvider: NSObject, UITableViewDataSource, UITableViewDelegate {

    var metrics: [Metric]?

    init(tableView: UITableView) {
        tableView.register(MetricCell.self, forCellReuseIdentifier: Constants.cellReuseIdentifier)
    }

    // MARK: UITableViewDataSource

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return metrics?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellReuseIdentifier,
                                                 for: indexPath) as! MetricCell

        return cell
    }

    // MARK: UITableViewDelegate

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constants.cellHeight
    }

}

private extension MetricsDataProvider {

    struct Constants {
        static let cellHeight: CGFloat = 200.0
        static let cellReuseIdentifier = "com.robot64.metric-reuse-id"
    }

}
