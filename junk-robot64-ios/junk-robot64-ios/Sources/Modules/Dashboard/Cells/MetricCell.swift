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

    func setData(_ someData: [MetricData]) {
        let values = someData.map { ChartDataEntry(x: $0.date.timeIntervalSince1970, y: $0.value) }
        let set = LineChartDataSet(values: values, label: "Test dataset")
        let data = LineChartData(dataSet: set)

        self.chartView.data = data
    }

}

private extension MetricCell {

    struct Constants {
        static let hinset: CGFloat = 8.0
        static let vInset: CGFloat = 4.0
    }

    func addChart() {
        let chartView = LineChartView()

        chartView.chartDescription?.enabled = false
        chartView.dragEnabled = false
        chartView.setScaleEnabled(false)
        chartView.pinchZoomEnabled = false
        chartView.isUserInteractionEnabled = false

        self.roundedView.addSubview(chartView)
        self.chartView = chartView

        //        // x-axis limit line
        //        let llXAxis = ChartLimitLine(limit: 10, label: "Index 10")
        //        llXAxis.lineWidth = 4
        //        llXAxis.lineDashLengths = [10, 10, 0]
        //        llXAxis.labelPosition = .rightBottom
        //        llXAxis.valueFont = .systemFont(ofSize: 10)
        //
        //        chartView.xAxis.gridLineDashLengths = [10, 10]
        //        chartView.xAxis.gridLineDashPhase = 0
        //
        //        let ll1 = ChartLimitLine(limit: 150, label: "Upper Limit")
        //        ll1.lineWidth = 4
        //        ll1.lineDashLengths = [5, 5]
        //        ll1.labelPosition = .rightTop
        //        ll1.valueFont = .systemFont(ofSize: 10)
        //
        //        let ll2 = ChartLimitLine(limit: -30, label: "Lower Limit")
        //        ll2.lineWidth = 4
        //        ll2.lineDashLengths = [5,5]
        //        ll2.labelPosition = .rightBottom
        //        ll2.valueFont = .systemFont(ofSize: 10)
        //
        //        let leftAxis = chartView.leftAxis
        //        leftAxis.removeAllLimitLines()
        //        leftAxis.addLimitLine(ll1)
        //        leftAxis.addLimitLine(ll2)
        //        leftAxis.axisMaximum = 200
        //        leftAxis.axisMinimum = -50
        //        leftAxis.gridLineDashLengths = [5, 5]
        //        leftAxis.drawLimitLinesBehindDataEnabled = true
        //
        //        chartView.rightAxis.enabled = false
        //
        //        //[_chartView.viewPortHandler setMaximumScaleY: 2.f];
        //        //[_chartView.viewPortHandler setMaximumScaleX: 2.f];
        //
        //        let marker = BalloonMarker(color: UIColor(white: 180/255, alpha: 1),
        //                                   font: .systemFont(ofSize: 12),
        //                                   textColor: .white,
        //                                   insets: UIEdgeInsets(top: 8, left: 8, bottom: 20, right: 8))
        //        marker.chartView = chartView
        //        marker.minimumSize = CGSize(width: 80, height: 40)
        //        chartView.marker = marker
        //
        //        chartView.legend.form = .line
        //
        //        chartView.animate(xAxisDuration: 2.5)
    }

}
