import Foundation
import UIKit
enum Theme: Int, CustomStringConvertible {
    case light
    case dark
    init?(typeString: String) {
        switch typeString.lowercased() {
        case "light":
            self.init(rawValue: 0)
        case "dark":
            self.init(rawValue: 1)
        default:
            return nil
        }
    }
    var applicationBackgroundColor: CGColor {
        switch self {
        case .light: return #colorLiteral(red: 0.9921568627, green: 0.9137254902, blue: 0.4705882353, alpha: 1)
        case .dark: return #colorLiteral(red: 0.1333333333, green: 0.5294117647, blue: 0.8039215686, alpha: 1)
        }
    }
    var expensesFontColor: UIColor {
        switch self {
        case .light: return #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        case .dark: return #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        }
    }
    var settingsOptionsFontColor: UIColor {
        switch self {
        case .light: return #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.6)
        case .dark: return #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        }
    }
    var selectedButtonColor: UIColor {
        switch self {
        case .light: return #colorLiteral(red: 0.46, green: 0.29, blue: 0.96, alpha: 0.2)
        case .dark: return #colorLiteral(red: 0.46, green: 0.29, blue: 0.96, alpha: 1)
        }
    }
    var selectedButtonTextColor: UIColor {
        switch self {
        case .light: return #colorLiteral(red: 0.46, green: 0.29, blue: 0.96, alpha: 1)
        case .dark: return #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        }
    }
    var buttonColor: UIColor {
        switch self {
        case .light: return #colorLiteral(red: 0.95, green: 0.96, blue: 0.96, alpha: 1)
        case .dark: return #colorLiteral(red: 0.22, green: 0.22, blue: 0.22, alpha: 1)
        }
    }
    var totalCostViewColor: CGColor {
        switch self {
        case .light: return #colorLiteral(red: 0.79897964, green: 0.2938711643, blue: 0.1686518788, alpha: 1)
        case .dark: return #colorLiteral(red: 0.12, green: 0.12, blue: 0.12, alpha: 1)
        }
    }
    var doneToolBarColor: UIColor {
        switch self {
        case .light: return #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        case .dark: return #colorLiteral(red: 0.12, green: 0.12, blue: 0.12, alpha: 1)
        }
    }
    var doneKeyboardButtonColor: UIColor {
        switch self {
        case .light, .dark: return #colorLiteral(red: 0.5388125777, green: 0.4061352313, blue: 0.9692879319, alpha: 1)
        }
    }
    var selectedExpenseColor: UIColor {
        switch self {
        case .light: return #colorLiteral(red: 0.46, green: 0.29, blue: 0.96, alpha: 0.2)
        case .dark: return #colorLiteral(red: 0.5388125777, green: 0.4061352313, blue: 0.9692879319, alpha: 1)
        }
    }
    var selectedExpenseFontColor: UIColor {
        switch self {
        case .light: return #colorLiteral(red: 0.5388125777, green: 0.4061352313, blue: 0.9692879319, alpha: 1)
        case .dark: return #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        }
    }
    var choosePeriodLabelColor: UIColor {
        switch self {
        case .light: return #colorLiteral(red: 0.12, green: 0.12, blue: 0.12, alpha: 0.4)
        case .dark: return #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        }
    }
    var deleteButtonColor: UIColor {
        switch self {
        case .light: return #colorLiteral(red: 1, green: 0.231, blue: 0.188, alpha: 0.4)
        case .dark: return #colorLiteral(red: 0.99, green: 0.24, blue: 0.22, alpha: 1)
        }
    }
    var deleteButtonTextColor: UIColor {
        switch self {
        case .light: return #colorLiteral(red: 0.99, green: 0.24, blue: 0.22, alpha: 1)
        case .dark: return #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        }
    }
    var addBarButtonImage: UIImage{
        switch self {
        case .light: return #imageLiteral(resourceName: "AddIcon")
        case .dark: return #imageLiteral(resourceName: "AddIconWhite")
        }
    }
    var xIconImage: UIImage{
        switch self {
        case .light: return UIImage.init(named: "XIcon")!
        case .dark: return UIImage.init(named: "XIconWhite")!
        }
    }
    var backIconImage: UIImage{
        switch self {
        case .light: return UIImage.init(named: "BackArrow")!
        case .dark: return UIImage.init(named: "BackArrow")!
        }
    }
    var noExpenseBackgroundImage: UIImage{
        switch self {
        case .light: return UIImage.init(named: "AddNewExpense")!
        case .dark: return UIImage.init(named: "Dark $ Background")!
        }
    }
    var textFieldColor: CGColor {
        switch self {
        case .light: return #colorLiteral(red: 0.95, green: 0.96, blue: 0.96, alpha: 1)
        case .dark: return #colorLiteral(red: 0.12, green: 0.12, blue: 0.12, alpha: 1)
        }
    }
    var panAndDividerColor: UIColor {
        switch self {
        case .light: return #colorLiteral(red: 0.77, green: 0.77, blue: 0.77, alpha: 1)
        case .dark: return #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.2)
        }
    }
    var selectorButtonColor: UIColor {
        switch self {
        case .light, .dark: return #colorLiteral(red: 0.95, green: 0.96, blue: 0.96, alpha: 0)
        }
    }
    var selectorButtonSelectedColor: UIColor {
        switch self {
        case .light, .dark: return #colorLiteral(red: 0.5388125777, green: 0.4061352313, blue: 0.9692879319, alpha: 1)
        }
    }
    var description: String {
        switch self {
        case .light: return "Light"
        case .dark: return "Dark"
        }
    }
}
