//
//  FavoritesVideoGameListRouter.swift
//  VideoGameApp
//
//  Created by mertcan YAMAN on 2.08.2023.
//

import UIKit

protocol FavoritesVideoGameListRoutingLogic {
    func routeToDetailVideoGame(segue: UIStoryboardSegue?)
}

protocol FavoritesVideoGameListDataPassing {}

final class FavoritesVideoGameListRouter: NSObject,
                                          FavoritesVideoGameListRoutingLogic,
                                          FavoritesVideoGameListDataPassing {
    weak var viewController: FavoritesVideoGameListViewController?
    var dataStore: FavoritesVideoGameListDataStore?
    
    func routeToDetailVideoGame(segue: UIStoryboardSegue?) {
        if let segue = segue {
            let destinationVC = segue.destination as! VideoGameDetailViewController
            var destinationDS = destinationVC.router?.dataStore
            guard let destination = destinationDS else { return }
            passDataToStudentList(source: dataStore!, destination: &destinationDS!)
        } else {
            let storyboard = UIStoryboard(name: "VideoGame", bundle: nil)
            let destinationVC = storyboard
                .instantiateViewController(withIdentifier: "VideoGameDetailViewController") as! VideoGameDetailViewController
            var destinationDS = destinationVC.router!.dataStore!
            passDataToStudentList(source: dataStore!, destination: &destinationDS)
            navigateToStudentList(source: viewController!, destination: destinationVC)
        }
    }
    
    func passDataToStudentList(source: FavoritesVideoGameListDataStore, destination: inout VideoGameDetailDataStore) {
        destination.gameID = source.gameID
    }
    
    func navigateToStudentList(source: FavoritesVideoGameListViewController, destination: VideoGameDetailViewController) {
        source.show(destination, sender: nil)
    }
}
