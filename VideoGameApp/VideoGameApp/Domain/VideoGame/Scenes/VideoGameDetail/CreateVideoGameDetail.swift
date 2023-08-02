//
//  CreateVideoGameDetail.swift
//  VideoGameApp
//
//  Created by mertcan YAMAN on 2.08.2023.
//

import Foundation

extension VideoGameDetailViewController {
    func setup() {
        let viewController = self
        let interactor = VideoGameDetailInteractor()
        let presenter = VideoGameDetailPresenter()
        let router = VideoGameDetailRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
}
