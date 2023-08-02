//
//  CreateSplash.swift
//  VideoGameApp
//
//  Created by mertcan YAMAN on 2.08.2023.
//

import Foundation

extension SplashViewController {
    func setup() {
        let viewController = self
        let interactor = SplashInteractor()
        let presenter = SplashPresenter()
        let router = SplashRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
}
