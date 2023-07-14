//
//  BaseViewController.swift
//  VideoGameApp
//
//  Created by mertcan YAMAN on 14.07.2023.
//

import UIKit

protocol BaseViewControllerProtocol: AnyObject {
    func showAlert(
        _ title: String,
        _ message: String,
        _ action: (() -> Void)?
    )
    func delay(_ delay: Double, closure: @escaping () -> Void)
}

class BaseViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func delay(_ delay: Double, closure: @escaping () -> Void) {
        let when = DispatchTime.now() + delay
        DispatchQueue.main.asyncAfter(deadline: when, execute: closure)
    }
}

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
}
