import UIKit

final class RootTBC: UITabBarController {

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nil, bundle: nil)

        self.commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        commonInit()
    }

    private func commonInit() {
        let vcs = [
            RootNC(rootViewController: DashboardVC()),
            StubVC(tbiImage: R.image.stethescope()!),
            StubVC(tbiImage: R.image.profile()!)
        ]

        self.viewControllers = vcs
        self.tabBar.tintColor = .mainColor
    }

}

private extension RootTBC {

    class StubVC: UIViewController {

        init(tbiImage: UIImage) {
            super.init(nibName: nil, bundle: nil)

            self.tabBarItem.image = tbiImage
            self.tabBarItem.title = "Stub"
        }

        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

    }

}
