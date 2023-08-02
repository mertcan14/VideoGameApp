//
//  CreateVideoGameList.swift
//  VideoGameApp
//
//  Created by mertcan YAMAN on 2.08.2023.
//

import Foundation

extension VideoGameListViewController {
    func setup() {
        let viewController = self
        let interactor = VideoGameListInteractor()
        let presenter = VideoGameListPresenter()
        let router = VideoGameListRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
}
