import UIKit
import Charts

class WordViewController: UIViewController {

    var wordView: NewWordView!
    var pieChart: PieChartView!
    var word: Word!

    override func viewDidLoad() {
        initWordView()
        initPieChart()
        initGradientColor()
    }

    func initWordView() {
        wordView = NewWordView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height / 2))

        wordView.nativeLabel.text = word.native
        wordView.englishLabel.text = word.english
        wordView.transliterationLabel.text = word.transliteration

        view.addSubview(wordView)
    }

    func initPieChart() {
        let yVal = wordView.frame.height
        let frame = CGRect(x: 0, y: yVal, width: view.frame.width, height: view.frame.height / 2)
        pieChart = PieChartView(frame: frame)

        pieChart.chartDescription?.text = ""

        pieChart.legend.textColor = UIColor.white
        pieChart.legend.formSize = 16
        pieChart.legend.font = UIFont(name: "HelveticaNeue-Bold", size: 16)!

        pieChart.drawHoleEnabled = false
        pieChart.rotationEnabled = false

        pieChart.data = getPieChartData()

        pieChart.noDataText = "Not Enough Data"

        view.addSubview(pieChart)
    }

    func getPieChartData() -> PieChartData? {

        if Int(word.correctCount) == 0 && Int(word.incorrectCount) == 0 {
            return nil
        }

        let correct = PieChartDataEntry(value: Double(word.correctCount), label: "correct")
        let incorrect = PieChartDataEntry(value: Double(word.incorrectCount), label: "incorrect")

        let dataSet = PieChartDataSet(values: [correct, incorrect], label: "")
        dataSet.colors = ChartColorTemplates.joyful()

        let data = PieChartData(dataSet: dataSet)

        let formatter = NumberFormatter()
        formatter.minimumFractionDigits = 0
        formatter.minimumIntegerDigits = 1
        data.setValueFormatter(DefaultValueFormatter(formatter: formatter))

        return data
    }

    func initGradientColor() {
        let gl = CAGradientLayer()
        gl.frame = self.view.frame
        gl.colors = [AthenaPalette.floral.cgColor, AthenaPalette.yankeesBlue.cgColor]
        gl.locations = [0.0, 1.0]
        view.layer.insertSublayer(gl, at: 0)
    }
}

//extension WordViewController: ChartViewDelegate {
//
//}
