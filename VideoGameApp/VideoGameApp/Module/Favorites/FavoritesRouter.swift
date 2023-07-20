//
//  FavoritesRouter.swift
//  VideoGameApp
//
//  Created by mertcan YAMAN on 20.07.2023.
//

import Foundation

enum FavoritesRoutes {
    
}

protocol FavoritesRouterProtocol: AnyObject {
    func navigate(_ route: FavoritesRoutes)
}

final class FavoritesRouter {
    weak var viewController: FavoritesViewController?
    
    static func createModule() -> FavoritesViewController {
        let view = FavoritesViewController()
        let interactor = FavoritesInteractor()
        let router = FavoritesRouter()
        let presenter = FavoritesPresenter(view, router, interactor)
        view.presenter = presenter
        interactor.output = presenter
        router.viewController = view
        return view
    }
}

extension FavoritesRouter: FavoritesRouterProtocol {
    func navigate(_ route: FavoritesRoutes) {
        switch route {
            
        }
    }
}
