//
//  FiltersViewController.swift
//  VideoGameApp
//
//  Created by mertcan YAMAN on 25.07.2023.
//

import UIKit

private let selectedOrderImage: UIImage? = UIImage(systemName: "checkmark.circle.fill")
private let unselectedOrderImage: UIImage? = UIImage(systemName: "circle.fill")
// MARK: - Enum OrderEnum
enum OrderEnum: String {
    case metacriticLowToHigh = "metacritic"
    case metacriticHighToLow = "-metacritic"
    case releasedOlderToNew = "released"
    case releasedNewToOlder = "-released"
    case ratingLowToHigh = "rating"
    case ratingHighToLow = "-rating"
}
// MARK: - Protocol FiltersViewControllerProtocol
protocol FiltersViewControllerProtocol: BaseViewControllerProtocol {
    func closeScreen()
    func checkTextFieldsForMetacritic() -> String?
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
    public var presenter: FiltersPresenterProtocol!
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
        presenter.setSortButtonTag(button.tag)
    }
    
    @IBAction func searchButtonClicked(_ sender: Any) {
        presenter.fetchWithFilters()
        closeScreen()
    }
    // MARK: - Private Methods
    private func deselectAllButtons() {
        for subView in orderView.subviews {
            if let button = subView as? UIButton {
                button.isSelected = false
                button.tintColor = .lightGray
            }
        }
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
    
    private func configTextField() {
        metacriticMinTextField.layer.borderWidth = 0.7
        metacriticMaxTextField.layer.borderWidth = 0.7
    }
}
// MARK: - Extension FiltersViewControllerProtocol
extension FiltersViewController: FiltersViewControllerProtocol {
    func closeScreen() {
        dismiss(animated: true)
    }
    
    func checkTextFieldsForMetacritic() -> String? {
        if metacriticMinTextField.text != "" || metacriticMaxTextField.text != "" {
            let minPoint = metacriticMinTextField.text == "" ? "1" : metacriticMinTextField.text
            let maxPoint = metacriticMaxTextField.text == "" ? "100" : metacriticMaxTextField.text
            let value = "\(minPoint!),\(maxPoint!)"
            return value
        }
        return nil
    }
}
// MARK: - Extension UITextFieldDelegate
extension FiltersViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let char = string.cString(using: String.Encoding.utf8) {
            let isBackSpace = strcmp(char, "\\b")
            if isBackSpace == -92 {
                return true
            }
        }
        guard let text = textField.text else { return false }
        if string.rangeOfCharacter(from: CharacterSet.decimalDigits.inverted) == nil && text.count < 2 {
            return true
        } else {
            return false
        }
    }
}
