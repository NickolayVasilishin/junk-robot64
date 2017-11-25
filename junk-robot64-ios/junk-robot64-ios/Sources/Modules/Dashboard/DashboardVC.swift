import UIKit
import SnapKit

final class DashboardVC: UIViewController {

    private var dataProvider: MetricsDataProvider!
    private weak var tableView: UITableView!

    // MARK: Initialization

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)

        self.commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        self.commonInit()
    }

    // MARK: View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupUI()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        self.receiveMetrics()
    }

}

// MARK: - Private

private extension DashboardVC {

    // MARK: - Common

    func commonInit() {
        self.tabBarItem.image = R.image.dashboard()
        self.tabBarItem.title = Constants.moduleName
        self.navigationItem.title = Constants.moduleName
    }

    struct Constants {
        static let moduleName = "Dashboard"
    }

    // MARK: UI

    func setupUI() {
        self.setupTableView()
    }

    func setupTableView() {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.separatorStyle = .none

        self.dataProvider = MetricsDataProvider(tableView: tableView)
        tableView.dataSource = self.dataProvider
        tableView.delegate = self.dataProvider

        self.view.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.edges.equalTo(self.view.safeAreaLayoutGuide)
        }

        self.tableView = tableView
    }

    // MARK: Network BL

    func receiveMetrics() {
        NetworkLayer.getMetrics { (metrics) in
            guard let metrics = metrics else { return }
            self.dataProvider.metrics = metrics
            self.tableView.reloadData()
        }
    }

}
