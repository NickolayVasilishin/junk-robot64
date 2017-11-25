import UIKit

class MetricCell: UITableViewCell {

    private weak var roundedView: UIView!

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        self.contentView.backgroundColor = .white
        let roundedView = UIView()
        roundedView.backgroundColor = .brown
        roundedView.clipsToBounds = true
        roundedView.layer.cornerRadius = 6.0
        
        contentView.addSubview(roundedView)
        self.roundedView = roundedView
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        self.roundedView.frame = self.contentView.frame.insetBy(dx: Constants.hinset, dy: Constants.vInset)
    }

}

private extension MetricCell {

    struct Constants {
        static let hinset: CGFloat = 8.0
        static let vInset: CGFloat = 4.0
    }

}
