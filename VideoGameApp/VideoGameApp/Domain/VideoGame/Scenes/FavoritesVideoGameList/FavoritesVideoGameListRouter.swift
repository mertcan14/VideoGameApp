//
//  FavoritesVideoGameListRouter.swift
//  VideoGameApp
//
//  Created by mertcan YAMAN on 2.08.2023.
//

import Foundation

protocol FavoritesVideoGameListRoutingLogic {}

protocol FavoritesVideoGameListDataPassing {}

final class FavoritesVideoGameListRouter: NSObject,
                                          FavoritesVideoGameListRoutingLogic,
                                          FavoritesVideoGameListDataPassing {
    weak var viewController: FavoritesVideoGameListViewController?
    var dataStore: FavoritesVideoGameListDataStore?
}
