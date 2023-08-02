//
//  NoInternetRouter.swift
//  VideoGameApp
//
//  Created by mertcan YAMAN on 2.08.2023.
//

import UIKit

protocol NoInternetRoutingLogic {
    func routeToHome()
}

protocol NoInternetDataPassing {
    var dataStore: NoInternetDataStore? { get }
}

final class NoInternetRouter: NSObject,
                          NoInternetRoutingLogic,
                          NoInternetDataPassing {
    weak var viewController: NoInternetViewController?
    var dataStore: NoInternetDataStore?
    
    func routeToHome() {
        let storyboard = UIStoryboard(name: "VideoGame", bundle: nil)
        let destinationVC = storyboard.instantiateViewController(withIdentifier: "TabBarViewController")
        destinationVC.modalPresentationStyle = .fullScreen
        destinationVC.modalTransitionStyle = .coverVertical
        viewController?.present(destinationVC, animated: true)
    }
}
