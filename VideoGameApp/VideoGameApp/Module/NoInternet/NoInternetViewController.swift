//
//  NoInternetViewController.swift
//  VideoGameApp
//
//  Created by mertcan YAMAN on 14.07.2023.
//

import UIKit

// swiftlint:disable:next type_name
protocol NoInternetViewControllerProtocol: AnyObject {
    func setTimeLabel(_ label: String)
    func hiddenTimeLabel()
    func showTimeLabel()
    func hideLoading()
    func enabledBtn(_ enabled: Bool)
}

final class NoInternetViewController: BaseViewController {
    var presenter: NoInternetPresenterProtocol!
    
    @IBOutlet weak var tryAgainBtn: UIButton!
    @IBOutlet weak var timeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func tryAgainBtnClicked(_ sender: Any) {
        showLoading()
        presenter.checkInternetConnection()
    }
}

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
