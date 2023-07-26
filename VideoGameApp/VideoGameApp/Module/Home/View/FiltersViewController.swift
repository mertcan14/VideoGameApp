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
    @IBOutlet weak var ratingHighToLowButton: UIButton!
    // MARK: - Variable Definitions
    private var isSelectedTag = 0
    public var presenter: HomePresenterProtocol!
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        configButtons()
    }
    // MARK: - IBAction Methods
    @IBAction func sortedButtonClicked(_ sender: Any) {
        guard let button = sender as? UIButton else { return }
        deselectAllButtons()
        button.tintColor = .systemBlue
        button.isSelected = true
        isSelectedTag = button.tag
    }
    
    @IBAction func searchButtonClicked(_ sender: Any) {
        let params: [String: String] = [
            "ordering": getByTag()
        ]
        presenter.fetchWithFilters(params)
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
    
    private func getByTag() -> String {
        if isSelectedTag == 1 {
            return OrderEnum.ratingHighToLow.rawValue
        } else if isSelectedTag == 2 {
            return OrderEnum.ratingLowToHigh.rawValue
        } else if isSelectedTag == 3 {
            return OrderEnum.releasedNewToOlder.rawValue
        } else if isSelectedTag == 4 {
            return OrderEnum.releasedOlderToNew.rawValue
        } else if isSelectedTag == 5 {
            return OrderEnum.metacriticHighToLow.rawValue
        } else {
            return OrderEnum.metacriticLowToHigh.rawValue
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
}
// MARK: - Extension FiltersViewControllerProtocol
extension FiltersViewController: FiltersViewControllerProtocol {
    func closeScreen() {
        dismiss(animated: true)
    }
}
