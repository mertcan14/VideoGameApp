//
//  SplashRouter.swift
//  VideoGameApp
//
//  Created by mertcan YAMAN on 14.07.2023.
//
import UIKit

protocol SplashRoutingLogic {
    func routeToNoInternet()
    func routeToHome()
}

protocol SplashDataPassing {}

final class SplashRouter: NSObject,
                          SplashRoutingLogic,
                          SplashDataPassing {
    weak var viewController: SplashViewController?
    var dataStore: SplashDataStore?
    
    func routeToNoInternet() {
        let storyboard = UIStoryboard(name: "Splash", bundle: nil)
        let destinationVC = storyboard.instantiateViewController(withIdentifier: "NoInternetViewController") as! NoInternetViewController
        destinationVC.modalPresentationStyle = .fullScreen
        destinationVC.modalTransitionStyle = .coverVertical
        navigateToStudentList(source: viewController!, destination: destinationVC)
    }
    
    func routeToHome() {
        let storyboard = UIStoryboard(name: "VideoGame", bundle: nil)
        let destinationVC = storyboard.instantiateViewController(withIdentifier: "TabBarViewController")
        destinationVC.modalPresentationStyle = .fullScreen
        destinationVC.modalTransitionStyle = .coverVertical
        viewController?.present(destinationVC, animated: true)
    }
    
    func navigateToStudentList(source: SplashViewController, destination: NoInternetViewController) {
        source.present(destination, animated: true)
    }
}
