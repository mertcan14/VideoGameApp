//
//  CreateNoInternet.swift
//  VideoGameApp
//
//  Created by mertcan YAMAN on 2.08.2023.
//

import Foundation

extension NoInternetViewController {
    func setup() {
        let viewController = self
        let interactor = NoInternetInteractor()
        let presenter = NoInternetPresenter()
        let router = NoInternetRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
}
