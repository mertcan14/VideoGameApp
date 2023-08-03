//
//  VideoGameListRouter.swift
//  VideoGameApp
//
//  Created by mertcan YAMAN on 31.07.2023.
//

import Foundation
import UIKit

protocol VideoGameListRoutingLogic {
    func routeToDetailVideoGame(segue: UIStoryboardSegue?)
}

protocol VideoGameListDataPassing {}

final class VideoGameListRouter: NSObject,
                                 VideoGameListRoutingLogic,
                                 VideoGameListDataPassing {
    weak var viewController: VideoGameListViewController?
    var dataStore: VideoGameListDataStore?
    
    func routeToDetailVideoGame(segue: UIStoryboardSegue?) {
        if let segue = segue {
            let destinationVC = segue.destination as! VideoGameDetailViewController
            var destinationDS = destinationVC.router?.dataStore
            guard let destination = destinationDS else { return }
            destinationVC.modalPresentationStyle = .fullScreen
            destinationVC.modalTransitionStyle = .coverVertical
            passDataToStudentList(source: dataStore!, destination: &destinationDS!)
        } else {
            let storyboard = UIStoryboard(name: "VideoGame", bundle: nil)
            let destinationVC = storyboard
                .instantiateViewController(withIdentifier: "VideoGameDetailViewController") as! VideoGameDetailViewController
            var destinationDS = destinationVC.router!.dataStore!
            destinationVC.modalPresentationStyle = .fullScreen
            destinationVC.modalTransitionStyle = .coverVertical
            passDataToStudentList(source: dataStore!, destination: &destinationDS)
            navigateToStudentList(source: viewController!, destination: destinationVC)
        }
    }
    
    func passDataToStudentList(source: VideoGameListDataStore, destination: inout VideoGameDetailDataStore) {
        destination.gameID = source.gameID
    }
    
    func navigateToStudentList(source: VideoGameListViewController, destination: VideoGameDetailViewController) {
        source.present(destination, animated: true)
    }
}
