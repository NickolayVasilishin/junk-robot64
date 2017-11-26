import UIKit
import Charts

class MetricCell: UITableViewCell {

    private weak var roundedView: UIView!
    private weak var chartView: LineChartView!

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        self.contentView.backgroundColor = .mainLightGray
        let roundedView = UIView()
        roundedView.backgroundColor = .white
        roundedView.clipsToBounds = true
        roundedView.layer.cornerRadius = 6.0
        
        contentView.addSubview(roundedView)
        self.roundedView = roundedView

        let layer = roundedView.layer
        layer.shadowOpacity = 0.25
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowRadius = 1.0
        layer.shadowOffset = CGSize(width: -0.5, height: 1.0)
        layer.masksToBounds = false

        self.addChart()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        self.roundedView.frame = self.contentView.frame.insetBy(dx: Constants.hinset, dy: Constants.vInset)
        self.chartView.frame = self.roundedView.bounds
    }

    func setData(_ someData: [MetricData], title: String, reference: Reference) {
        let values = someData.map { ChartDataEntry(x: $0.date.timeIntervalSince1970,
                                                   y: $0.value) }
        let set = LineChartDataSet(values: values, label: title)
        set.axisDependency = .left
        set.setColor(.mainTintColor)
        set.lineWidth = 1.5
        set.drawCirclesEnabled = false
        set.drawValuesEnabled = false
        set.fillColor = .mainTintColor
        set.drawCircleHoleEnabled = false

        let data = LineChartData(dataSet: set)
        self.chartView.data = data

        let ll1 = ChartLimitLine(limit: reference.max)
        ll1.lineWidth = 1
        ll1.lineDashLengths = [5, 5]

        let ll2 = ChartLimitLine(limit: reference.min)
        ll2.lineWidth = 1
        ll2.lineDashLengths = [5, 5]

        let leftAxis = chartView.leftAxis
        leftAxis.removeAllLimitLines()
        leftAxis.addLimitLine(ll1)
        leftAxis.addLimitLine(ll2)
        leftAxis.drawLimitLinesBehindDataEnabled = true

        let xAxis = chartView.xAxis
        xAxis.valueFormatter = DateValueFormatter()
    }

}

private extension MetricCell {

    struct Constants {
        static let hinset: CGFloat = 8.0
        static let vInset: CGFloat = 8.0
    }

    func addChart() {
        let chartView = LineChartView()

        chartView.chartDescription?.enabled = false
        chartView.dragEnabled = false
        chartView.setScaleEnabled(false)
        chartView.pinchZoomEnabled = false
        chartView.isUserInteractionEnabled = false
        chartView.drawGridBackgroundEnabled = false
        chartView.gridBackgroundColor = .clear
        chartView.legend.form = .line
        chartView.legend.enabled = true
        chartView.rightAxis.enabled = false

        self.roundedView.addSubview(chartView)
        self.chartView = chartView
    }

}
