import UIKit
protocol updateParentThemeDelegate {
    func updateParentTheme()
}
class TotalCostViewController: UIViewController {
    @IBOutlet weak var totalExpensesPriceLabel: UILabel!
    @IBOutlet weak var expensePeriodLabel: UILabel!
    @IBOutlet weak var expensesView: UIView!
    @IBOutlet weak var periodButtonSettingsView: UIView!
    @IBOutlet weak var buttonSettingStackView: UIStackView!
    @IBOutlet var expensePeriodButtons: [UIButton]!
    @IBOutlet weak var expenseTitleLabel: UILabel!
    @IBOutlet weak var settingsButton: UIButton!
    @IBOutlet weak var panLabel: UILabel!
    @IBOutlet weak var dividerLabel: UILabel!
    var expenseArray = [Expense]()
    var startPosition: CGPoint?
    let window = UIApplication.shared.keyWindow
    var bottomPadding: CGFloat?
    var yComponent = CGFloat()
    let defaults = UserDefaults.standard
    var expenseFrame = CGRect()
    var periodFrame = CGRect()
    var animationDuration = TimeInterval()
    var theme = Theme.init(rawValue: 0)
    let textColor = #colorLiteral(red: 0.5377323031, green: 0.4028604627, blue: 0.9699184299, alpha: 1)
    let backgroundColor = #colorLiteral(red: 0.4588235294, green: 0.2862745098, blue: 0.9607843137, alpha: 0.2)
    override func viewDidLoad() {
        super.viewDidLoad()
        expenseFrame = expensesView.frame
        periodFrame = periodButtonSettingsView.frame
        let gesture = UIPanGestureRecognizer.init(target: self, action: #selector(panGesture))
        view.addGestureRecognizer(gesture)
        let tapGesture = UITapGestureRecognizer.init(target: self, action: #selector(costTapGesture))
        expensesView.addGestureRecognizer(tapGesture)
        buttonSettingStackView.isHidden = true
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        theme = Theme.init(rawValue: defaults.integer(forKey: "SelectedTheme")) ?? Theme.init(rawValue: 0)
        updateTheme()
        UIView.animate(withDuration: 0.3) { [weak self] in
            guard let `self` = self else {return}
            self.buttonSettingStackView.isHidden = true
            let frame = self.view.frame
            if #available(iOS 11.0, *) {
                self.bottomPadding = self.window?.safeAreaInsets.bottom
            } else {
            }
            if let bottomPadding = self.bottomPadding {
                self.yComponent = UIScreen.main.bounds.height - self.expenseFrame.height - bottomPadding
            } else {
                self.yComponent = UIScreen.main.bounds.height - self.expenseFrame.height
            }
            self.view.frame = CGRect(x: 0, y: self.yComponent, width: frame.width, height: self.expenseFrame.height + self.periodFrame.height)
        }
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        expensesViewSetup()
    }
    @objc func panGesture(recognizer: UIPanGestureRecognizer){
        switch recognizer.state {
        case .changed:
            let translation = recognizer.translation(in: self.view)
            let y = self.view.frame.minY
            if let parent = parent as? ExpensesViewController, let bottomPadding = bottomPadding {
                let maxHeight = parent.view.frame.height - expenseFrame.height - periodFrame.height - bottomPadding
                let maxTranslation = maxHeight - yComponent
                if y+translation.y <= maxHeight {
                    self.view.frame = CGRect(x: 0, y: maxHeight, width: view.frame.width, height: view.frame.height)
                    buttonSettingStackView.alpha = 1
                    buttonSettingStackView.isHidden = false
                } else if y+translation.y >= yComponent {
                    self.view.frame = CGRect(x: 0, y: yComponent, width: view.frame.width, height: view.frame.height)
                    buttonSettingStackView.isHidden = true
                    buttonSettingStackView.alpha = 0
                } else {
                    self.view.frame = CGRect(x: 0, y: y + translation.y, width: view.frame.width, height: view.frame.height)
                    buttonSettingStackView.isHidden = false
                    buttonSettingStackView.alpha = (maxTranslation - (maxHeight - (y + translation.y)))/maxTranslation
                }
            }
            recognizer.setTranslation(CGPoint(x: 0, y: 0), in: self.view)
        case .ended, .cancelled, .failed:
            let velocity = recognizer.velocity(in: self.view).y
            let minY = self.view.frame.minY
            if let parent = parent as? ExpensesViewController, let bottomPadding = bottomPadding {
                let maxHeight = parent.view.frame.height - expenseFrame.height - periodFrame.height - bottomPadding
                let height = yComponent - maxHeight
                let currentY = yComponent - minY
                let snapToFrame: CGRect
                if (currentY > height/2 && velocity <= 0) || velocity <= -100 {
                    snapToFrame = CGRect(x: 0, y: maxHeight, width: view.frame.width, height: view.frame.height)
                    buttonSettingStackView.alpha = 1
                    buttonSettingStackView.isHidden = false
                } else {
                    snapToFrame = CGRect(x: 0, y: yComponent, width: view.frame.width, height: view.frame.height)
                    buttonSettingStackView.alpha = 0
                    buttonSettingStackView.isHidden = true
                }
                if abs(velocity) > 100 {
                    animationDuration = 0.5
                } else {
                    animationDuration = 0.3
                }
                UIView.animate(withDuration: self.animationDuration,
                               delay: 0,
                               usingSpringWithDamping: 0.5,
                               initialSpringVelocity: 0,
                               options: .allowUserInteraction,
                               animations: {
                    self.view.frame = snapToFrame
                }, completion: nil)
            }
        default:
            break;
        }
    }
    @objc func costTapGesture(recognizer: UITapGestureRecognizer){
        let minY = self.view.frame.minY
        let snapToFrame: CGRect
        if let parent = parent as? ExpensesViewController, let bottomPadding = bottomPadding {
            let maxHeight = parent.view.frame.height - expenseFrame.height - periodFrame.height - bottomPadding
            if minY == maxHeight {
                snapToFrame = CGRect(x: 0, y: yComponent, width: view.frame.width, height: view.frame.height)
                buttonSettingStackView.alpha = 0
                buttonSettingStackView.isHidden = true
            } else {
                snapToFrame = CGRect(x: 0, y: maxHeight, width: view.frame.width, height: view.frame.height)
                buttonSettingStackView.alpha = 1
                buttonSettingStackView.isHidden = false
            }
            UIView.animate(withDuration: 0.5,
                           delay: 0,
                           usingSpringWithDamping: 0.5,
                           initialSpringVelocity: 0,
                           options: .allowUserInteraction,
                           animations: {
                self.view.frame = snapToFrame
            }, completion: nil)
        }
    }
    func expensesViewSetup(){
        expensesView.clipsToBounds = false
        expensesView.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.2).cgColor
        expensesView.layer.shadowPath = UIBezierPath(roundedRect: expensesView.bounds, cornerRadius: 10).cgPath
        expensesView.layer.shadowOpacity = 1
        expensesView.layer.shadowRadius = 5
        expensesView.layer.shadowOffset = CGSize.zero
        if #available(iOS 11.0, *) {
            expensesView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        } else {
        }
        updateTheme()
    }
    func updateTheme(){
        expensesView.layer.backgroundColor = theme?.totalCostViewColor
        settingsButton.backgroundColor = theme?.buttonColor
        settingsButton.setTitleColor(theme?.expensesFontColor, for: .normal)
        periodButtonSettingsView.layer.backgroundColor = theme?.totalCostViewColor
        panLabel.backgroundColor = theme?.panAndDividerColor
        dividerLabel.backgroundColor = theme?.buttonColor
        updateLabels()
    }
    func updateLabels(){
        let savedPeriod = defaults.integer(forKey: "SelectedPeriod")
        expencePeriodSelected(expensePeriodButtons[savedPeriod])
    }
    func expensesLabelSetup(per timePeriod: Double = 12, with label: String = "per month"){
        var totalPrice = Double()
        for index in expenseArray.indices {
            totalPrice += expenseArray[index].yearPrice
        }
        let currencyFormatter = NumberFormatter()
        currencyFormatter.usesGroupingSeparator = true
        currencyFormatter.numberStyle = .currency
        currencyFormatter.locale = Locale.current
        let price = totalPrice/timePeriod
        totalExpensesPriceLabel.text = currencyFormatter.string(from: NSNumber(value: price))
        expensePeriodLabel.text = "per \(label.lowercased())"
        totalExpensesPriceLabel.textColor = theme?.expensesFontColor
        expenseTitleLabel.textColor = theme?.expensesFontColor
    }
    @IBAction func expencePeriodSelected(_ sender: UIButton) {
        for index in expensePeriodButtons.indices {
            if sender == expensePeriodButtons[index]{
                expensePeriodButtons[index].backgroundColor = theme?.selectedButtonColor
                expensePeriodButtons[index].setTitleColor(theme?.selectedButtonTextColor, for: .normal)
                defaults.set(Int(index), forKey: "SelectedPeriod")
            } else {
                expensePeriodButtons[index].backgroundColor =  theme?.buttonColor
                expensePeriodButtons[index].setTitleColor(theme?.expensesFontColor, for: .normal)
            }
        }
        let expensePeriod = Double(sender.tag)
        expensesLabelSetup(per: expensePeriod, with: sender.title(for: .normal)!)
    }
    func moveDown(){
        UIView.animate(withDuration: 0.3) {
            self.view.frame = CGRect(x: 0, y: UIScreen.main.bounds.height, width: self.view.frame.width, height: self.view.frame.height)
        }
    }
    func moveUp(){
        UIView.animate(withDuration: 0.3) {
            self.view.frame = CGRect(x: 0, y: self.yComponent, width: self.view.frame.width, height: self.view.frame.height)
        }
        buttonSettingStackView.isHidden = true
    }
    @IBAction func settingsButtonPressed(_ sender: UIButton) {
            UIView.animate(withDuration: 0.3) {
                self.buttonSettingStackView.isHidden = true
            }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! SetupSettingsViewController
        destinationVC.delegate = self
        let parentVC = parent as! ExpensesViewController
        UIView.animate(withDuration: 0.3) {
            self.moveUp()
            parentVC.navigationController?.view.alpha = 0.3
        }
    }
}
extension TotalCostViewController: UpdateThemeDelegate{
    func updateUserTheme(){
        theme = Theme.init(rawValue: defaults.integer(forKey: "SelectedTheme"))
        updateTheme()
        let parentVC = parent as! ExpensesViewController
        parentVC.theme = theme
        parentVC.updateTheme()
    }
}
