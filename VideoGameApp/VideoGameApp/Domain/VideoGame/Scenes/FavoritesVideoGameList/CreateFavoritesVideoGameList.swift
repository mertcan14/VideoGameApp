//
//  CreateFavoritesVideoGameList.swift
//  VideoGameApp
//
//  Created by mertcan YAMAN on 2.08.2023.
//

import Foundation

extension FavoritesVideoGameListViewController {
    func setup() {
        let viewController = self
        let interactor = FavoritesVideoGameListInteractor()
        let presenter = FavoritesVideoGameListPresenter()
        let router = FavoritesVideoGameListRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
}
