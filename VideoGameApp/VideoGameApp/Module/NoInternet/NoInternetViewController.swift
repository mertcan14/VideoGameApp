//
//  NoInternetViewController.swift
//  VideoGameApp
//
//  Created by mertcan YAMAN on 14.07.2023.
//

import UIKit
// MARK: - Protocol NoInternetViewControllerProtocol
protocol NoInternetViewControllerProtocol: BaseViewControllerProtocol {
    func setTimeLabel(_ label: String)
    func hiddenTimeLabel()
    func showTimeLabel()
    func enabledBtn(_ enabled: Bool)
}
// MARK: - Class NoInternetViewController
final class NoInternetViewController: BaseViewController {
    // MARK: - IBOutlet Definitions
    @IBOutlet weak var tryAgainBtn: UIButton!
    @IBOutlet weak var timeLabel: UILabel!
    // MARK: - Variable Definitions
    var presenter: NoInternetPresenterProtocol!
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    // MARK: - Funcs
    @IBAction func tryAgainBtnClicked(_ sender: Any) {
        showLoading()
        presenter.checkInternetConnection()
    }
}
// MARK: - Extension NoInternetViewControllerProtocol
extension NoInternetViewController: NoInternetViewControllerProtocol {
    func showTimeLabel() {
        DispatchQueue.main.async {
            self.timeLabel.isHidden = false
        }
    }

    func enabledBtn(_ enabled: Bool) {
        DispatchQueue.main.async {
            self.tryAgainBtn.isEnabled = enabled
        }
    }
    
    func setTimeLabel(_ label: String) {
        DispatchQueue.main.async {
            self.timeLabel.text = label
        }
    }
    
    func hiddenTimeLabel() {
        DispatchQueue.main.async {
            self.timeLabel.isHidden = true
        }
    }
}
