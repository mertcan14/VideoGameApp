//
//  FiltersViewController.swift
//  VideoGameApp
//
//  Created by mertcan YAMAN on 25.07.2023.
//

import UIKit

// MARK: - Enum OrderEnum
enum OrderEnum: String {
    case metacriticLowToHigh = "metacritic"
    case metacriticHighToLow = "-metacritic"
    case releasedOlderToNew = "released"
    case releasedNewToOlder = "-released"
    case ratingLowToHigh = "rating"
    case ratingHighToLow = "-rating"
}
// MARK: - Class FiltersViewController
final class FiltersViewController: BaseViewController {
    // MARK: - IBOutlet Definitions
    @IBOutlet weak var orderView: UIView!
    @IBOutlet weak var metacriticLowToHighButton: UIButton!
    @IBOutlet weak var metacriticHighToLowButton: UIButton!
    @IBOutlet weak var releasedOlderToNewButton: UIButton!
    @IBOutlet weak var releasedNewToOlderButton: UIButton!
    @IBOutlet weak var ratingLowToHighButton: UIButton!
    @IBOutlet weak var metacriticMinTextField: UITextField!
    @IBOutlet weak var metacriticMaxTextField: UITextField!
    @IBOutlet weak var ratingHighToLowButton: UIButton!
    // MARK: - Variable Definitions
    public var interactor: VideoGameListBusinessLogic?
    private let alertTitle: String = "Error"
    private let alertContentForMinMax: String = "The minimum value cannot be greater than the maximum."
    private let selectedOrderImage: UIImage? = UIImage(systemName: "checkmark.circle.fill")
    private let unselectedOrderImage: UIImage? = UIImage(systemName: "circle.fill")
    private var selectedTag = 0
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        configButtons()
        configTextField()
    }
    // MARK: - IBAction Methods
    @IBAction func sortedButtonClicked(_ sender: Any) {
        guard let button = sender as? UIButton else { return }
        deselectAllButtons()
        button.tintColor = .systemBlue
        button.isSelected = true
        selectedTag = button.tag
    }
    
    @IBAction func searchButtonClicked(_ sender: Any) {
        fetchWithFilters()
        closeScreen()
    }
    
    private func closeScreen() {
        dismiss(animated: true)
    }
    
    private func fetchWithFilters() {
        guard let params = setParams() else {
            self.closeScreen()
            return
        }
        self.showLoading()
        interactor?.fetchWithParams(params: params)
    }
}
// MARK: - Extension UITextFieldDelegate
extension FiltersViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if string.charIsBackSpace() {
            return true
        }
        guard let text = textField.text else { return false }
        if string.rangeOfCharacter(from: CharacterSet.decimalDigits.inverted) == nil && text.count < 2 {
            return true
        } else {
            return false
        }
    }
}
// MARK: - Extension For Private Funcs
extension FiltersViewController {
    // MARK: - Orders Funcs
    private func deselectAllButtons() {
        for subView in orderView.subviews {
            if let button = subView as? UIButton {
                button.isSelected = false
                button.tintColor = .lightGray
            }
        }
    }
    
    private func checkTextFields() -> Bool {
        if metacriticMinTextField.text != "" && metacriticMaxTextField.text != "" {
            let max = Int(metacriticMaxTextField.text ?? "100") ?? 100
            let min = Int(metacriticMinTextField.text ?? "0") ?? 0
            if min > max {
                self.showAlert(alertTitle, alertContentForMinMax, nil)
                return false
            }
            return true
        } else if metacriticMinTextField.text != "" || metacriticMaxTextField.text != "" {
            return true
        }
        return false
    }
    
    private func configButtons() {
        metacriticLowToHighButton.setImage(selectedOrderImage, for: .selected)
        metacriticLowToHighButton.setImage(unselectedOrderImage, for: .normal)
        metacriticHighToLowButton.setImage(selectedOrderImage, for: .selected)
        metacriticHighToLowButton.setImage(unselectedOrderImage, for: .normal)
        releasedOlderToNewButton.setImage(selectedOrderImage, for: .selected)
        releasedOlderToNewButton.setImage(unselectedOrderImage, for: .normal)
        releasedNewToOlderButton.setImage(selectedOrderImage, for: .selected)
        releasedNewToOlderButton.setImage(unselectedOrderImage, for: .normal)
        ratingLowToHighButton.setImage(selectedOrderImage, for: .selected)
        ratingLowToHighButton.setImage(unselectedOrderImage, for: .normal)
        ratingHighToLowButton.setImage(selectedOrderImage, for: .selected)
        ratingHighToLowButton.setImage(unselectedOrderImage, for: .normal)
    }
    
    private func getByTag() -> String {
        if selectedTag == 1 {
            return OrderEnum.ratingHighToLow.rawValue
        } else if selectedTag == 2 {
            return OrderEnum.ratingLowToHigh.rawValue
        } else if selectedTag == 3 {
            return OrderEnum.releasedNewToOlder.rawValue
        } else if selectedTag == 4 {
            return OrderEnum.releasedOlderToNew.rawValue
        } else if selectedTag == 5 {
            return OrderEnum.metacriticHighToLow.rawValue
        } else {
            return OrderEnum.metacriticLowToHigh.rawValue
        }
    }
    // MARK: - Metacritic Funcs
    private func checkTextFieldsForMetacritic() -> String? {
        if checkTextFields() {
            let minPoint = metacriticMinTextField.text == "" ? "1" : metacriticMinTextField.text
            let maxPoint = metacriticMaxTextField.text == "" ? "100" : metacriticMaxTextField.text
            let value = "\(minPoint!),\(maxPoint!)"
            return value
        }
        return nil
    }
    
    private func setParams() -> [String: String]? {
        var params: [String: String] = [:]
        if let metacritic = self.checkTextFieldsForMetacritic() {
            params["metacritic"] = metacritic
        }
        if selectedTag != 0 {
            params["ordering"] = getByTag()
        }
        if params != [:] {
            return params
        }
        return nil
    }
    
    private func configTextField() {
        metacriticMinTextField.layer.borderWidth = 0.7
        metacriticMaxTextField.layer.borderWidth = 0.7
    }
}
