import UIKit
import Charts
import SnapKit

class TestVC: UIViewController {

    private weak var chartView: LineChartView!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .white

        self.setupChartView()
    }

}

// MARK: - Private

private extension TestVC {

    func setupChartView() {
        let chartView = LineChartView()

        chartView.chartDescription?.enabled = false
        chartView.dragEnabled = true
        chartView.setScaleEnabled(true)
        chartView.pinchZoomEnabled = true

        self.view.addSubview(chartView)
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

        self.chartView.snp.makeConstraints {
            $0.edges.equalTo(self.view.safeAreaLayoutGuide.snp.edges)
        }

        let someData: [SomeDataObject] = [
            .init(x: 0.0, y: 0.0),
            .init(x: 1.0, y: 2.0),
            .init(x: 3.0, y: 7.0),
            .init(x: 5.0, y: 0.0)
        ]

        self.setData(someData)
    }

    func setData(_ someData: [SomeDataObject]) {
        let values = someData.map { ChartDataEntry(x: $0.x, y: $0.y) }
        let set = LineChartDataSet(values: values, label: "Test dataset")
        let data = LineChartData(dataSet: set)

        self.chartView.data = data
    }

    struct SomeDataObject {
        let x: Double
        let y: Double
    }

}
