//
//  NoInternetViewController.swift
//  VideoGameApp
//
//  Created by mertcan YAMAN on 14.07.2023.
//

import UIKit
// MARK: - Protocol NoInternetDisplayLogic
protocol NoInternetDisplayLogic: AnyObject {
    func getIsConnection(viewModel: NoInternetModels.CheckInternetConnection.ViewModel)
}
// MARK: - Class NoInternetViewController
final class NoInternetViewController: BaseViewController {
    // MARK: - IBOutlet Definitions
    @IBOutlet weak var tryAgainBtn: UIButton!
    @IBOutlet weak var timeLabel: UILabel!
    // MARK: - Variable Definitions
    internal var interactor: NoInternetBusinessLogic?
    internal var router: (NSObjectProtocol &
                          NoInternetRoutingLogic &
                          NoInternetDataPassing)?
    private let maxSecondForWait: Int = 90
    private let addSecondForWait: Int = 10
    private var timeWaitStarter: Int = 5
    private var timeWait: Int = 5
    private var timer: Timer?
    // MARK: - Lifecycle Methods
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
      super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
      setup()
    }

    required init?(coder aDecoder: NSCoder) {
      super.init(coder: aDecoder)
      setup()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    // MARK: - Funcs
    @IBAction func tryAgainBtnClicked(_ sender: Any) {
        showLoading()
        interactor?.checkInternetConnection()
    }
    
    func enabledBtn(_ enabled: Bool) {
        DispatchQueue.main.async { [weak self] in
            self?.tryAgainBtn.isEnabled = enabled
        }
    }
    
    func setTimeLabel(_ label: String) {
        DispatchQueue.main.async { [weak self] in
            self?.timeLabel.text = label
        }
    }
    
    func hiddenTimeLabel(_ isHide: Bool) {
        DispatchQueue.main.async { [weak self] in
            self?.timeLabel.isHidden = isHide
        }
    }
    
    private func timeString(_ time: TimeInterval) -> String {
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        return String(format: "%02i:%02i", minutes, seconds)
    }
    
    private func runTimer() {
        guard timer == nil else { return }
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(updateTimer)), userInfo: nil, repeats: true)
    }
    
    private func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    @objc func updateTimer() {
        if timeWait != 0 {
            timeWait -= 1
            self.setTimeLabel(self.timeString(TimeInterval(timeWait)))
        } else {
            self.enabledBtn(true)
            self.hiddenTimeLabel(true)
            self.stopTimer()
        }
    }
}
// MARK: - Extension NoInternetViewControllerProtocol
extension NoInternetViewController: NoInternetDisplayLogic {
    func getIsConnection(viewModel: NoInternetModels.CheckInternetConnection.ViewModel) {
        self.hideLoading()
        if viewModel.isConnection {
            self.router?.routeToHome()
        } else {
            timeWait = timeWaitStarter
            self.setTimeLabel(self.timeString(TimeInterval(timeWait)))
            self.hiddenTimeLabel(true)
            self.enabledBtn(false)
            self.runTimer()
            if timeWaitStarter < maxSecondForWait {
                timeWaitStarter += addSecondForWait
            }
        }
    }
}
