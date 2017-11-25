import UIKit

final class DashboardVC: UIViewController {

    // MARK: Initialization

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)

        self.commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        self.commonInit()
    }

    private func commonInit() {
        self.tabBarItem.image = R.image.dashboard()
        self.tabBarItem.title = Constants.moduleName
        self.navigationItem.title = Constants.moduleName
    }

    // MARK: View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
    }

}

private extension DashboardVC {

    struct Constants {
        static let moduleName = "Dashboard"
    }

}
