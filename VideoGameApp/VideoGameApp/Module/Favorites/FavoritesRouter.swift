//
//  FavoritesRouter.swift
//  VideoGameApp
//
//  Created by mertcan YAMAN on 20.07.2023.
//

import Foundation
// MARK: Enum FavoritesRoutes
enum FavoritesRoutes {
    case goDetailScreen(_ idOfVideoGame: String)
}
// MARK: Protocol FavoritesRouterProtocol
protocol FavoritesRouterProtocol: AnyObject {
    func navigate(_ route: FavoritesRoutes)
}
// MARK: Class FavoritesRouter
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
// MARK: Class FavoritesRouterProtocol
extension FavoritesRouter: FavoritesRouterProtocol {
    func navigate(_ route: FavoritesRoutes) {
        switch route {
        case .goDetailScreen(let idOfVideoGame):
            let sendVC = DetailVideoGameRouter.createModule()
            sendVC.presenter.setIdOfVideoGame(idOfVideoGame)
            viewController?.navigationController?.pushViewController(sendVC, animated: true)
        }
    }
}
