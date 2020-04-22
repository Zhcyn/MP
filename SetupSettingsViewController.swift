import UIKit
class SetupSettingsViewController: UIViewController {
    @IBOutlet weak var containerViewHeight: NSLayoutConstraint!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var pullLabelView: UIView!
    @IBOutlet weak var pullLabel: UILabel!
    var bottomPadding: CGFloat?
    let window = UIApplication.shared.keyWindow
    var delegate: TotalCostViewController?
    var settingsView: SettingsViewController?
    var theme = Theme.init(rawValue: 0)
    var defaults = UserDefaults.standard
    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 11.0, *) {
            if let bottomPadding = self.window?.safeAreaInsets.bottom {
                containerViewHeight.constant = containerViewHeight.constant + bottomPadding
            }
        } else {
        }
        theme = Theme.init(rawValue: defaults.integer(forKey: "SelectedTheme")) ?? Theme.init(rawValue: 0)
        updateTheme()
        if #available(iOS 11.0, *) {
            pullLabelView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        } else {
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let navigationVC = segue.destination as! UINavigationController
        let destinationVC = navigationVC.topViewController as! SettingsViewController
        destinationVC.delegate = self
    }
    func updateTheme(){
        theme = Theme.init(rawValue: defaults.integer(forKey: "SelectedTheme"))
        pullLabelView.layer.backgroundColor = theme?.totalCostViewColor
        pullLabel.backgroundColor = theme?.panAndDividerColor
    }
    @objc func dismissView(){
        if let delegate = delegate {
            delegate.parent?.navigationController?.view.alpha = 1
        }
        dismiss(animated: true, completion: nil)
    }
}
