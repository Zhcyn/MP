import UIKit
protocol SortExpenseDelegate {
    func sortLabelAndExpenses()
}
class SortExpensesViewController: UIViewController {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var sortView: UIView!
    @IBOutlet var sortButtons: [UIButton]!
    @IBOutlet var tickImages: [UIImageView]!
    @IBOutlet weak var xIconButton: UIButton!
    var yComponent = CGFloat()
    var theme = Theme.init(rawValue: 0)
    let defaults = UserDefaults.standard
    var delegate: SettingsViewController?
    override func viewDidLoad() {
        super.viewDidLoad()
        theme = Theme.init(rawValue: defaults.integer(forKey: "SelectedTheme")) ?? Theme.init(rawValue: 0)
        updateTheme()
        sortTypeSelected(sortButtons[defaults.integer(forKey: "Sort")])
    }
    func updateTheme(){
        for index in sortButtons.indices {
            sortButtons[index].setTitleColor(theme?.expensesFontColor, for: .normal)
        }
        sortView.layer.backgroundColor = theme?.totalCostViewColor
    }
    @IBAction func sortTypeSelected(_ sender: UIButton) {
        for index in sortButtons.indices{
            if sortButtons[index] == sender {
                tickImages[index].isHidden = false
                defaults.set(index, forKey: "Sort")
            } else {
                tickImages[index].isHidden = true
            }
        }
        delegate?.sortLabelAndExpenses()
    }
    @IBAction func xButtonPressed(_ sender: UIButton) {
        navigationController?.popToRootViewController(animated: true)
    }
}
