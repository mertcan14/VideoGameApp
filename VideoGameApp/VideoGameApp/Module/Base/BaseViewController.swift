//
//  BaseViewController.swift
//  VideoGameApp
//
//  Created by mertcan YAMAN on 14.07.2023.
//

import UIKit
// MARK: - Protocol BaseViewControllerProtocol
protocol BaseViewControllerProtocol: AnyObject, LoadingShowable {
    func showAlert(
        _ title: String,
        _ message: String,
        _ action: (() -> Void)?
    )
    func delay(_ delay: Double, closure: @escaping () -> Void)
}
// MARK: - Class BaseViewController
class BaseViewController: UIViewController, LoadingShowable {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
    }
    
    func delay(_ delay: Double, closure: @escaping () -> Void) {
        let when = DispatchTime.now() + delay
        DispatchQueue.main.asyncAfter(deadline: when, execute: closure)
    }
}
// MARK: - Extension BaseViewControllerProtocol
extension BaseViewController: BaseViewControllerProtocol {
    func showAlert(
        _ title: String,
        _ message: String,
        _ action: (() -> Void)?
    ) {
        let alertController = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            guard let action else { return }
            action()
        }
        alertController.addAction(okAction)
        self.present(alertController, animated: true)
    }
    
    func showPopUp(
        _ title: String,
        _ message: String,
        buttonTitle: String? = "OK",
        buttonAction: (() -> Void)? = nil,
        cancelAction: (() -> Void)? = nil
    ) {
        let alertController = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )
        let okAction = UIAlertAction(title: buttonTitle, style: .default) { _ in
            guard let buttonAction else { return }
            buttonAction()
        }
        alertController.addAction(okAction)
        let cancelAction = UIAlertAction(title: "Cancel", style: .default) { _ in
            guard let cancelAction else { return }
            cancelAction()
        }
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true)
    }
}
