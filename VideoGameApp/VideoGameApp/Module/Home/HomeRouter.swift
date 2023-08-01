//
//  HomeRouter.swift
//  VideoGameApp
//
//  Created by mertcan YAMAN on 14.07.2023.
//

import UIKit
// MARK: - Enum HomeRoutes
enum HomeRoutes {
    case goDetailScreen(_ idOfVideoGame: String)
    case goNoInternetScreen
}
// MARK: - Protocol HomeRouterProtocol
protocol HomeRouterProtocol: AnyObject {
    func navigate(_ route: HomeRoutes)
}
// MARK: - Class HomeRouter
final class HomeRouter {
    weak var viewController: HomeViewController?
    
    static func createModule() -> HomeViewController {
        guard let view = UIStoryboard(name: "HomeViewController", bundle: nil)
            .instantiateViewController(withIdentifier: "HomeViewController") as? HomeViewController else { return HomeViewController() }
        let router = HomeRouter()
        let interactor = HomeInteractor()
        let presenter = HomePresenter(view, router, interactor)
        view.presenter = presenter
        interactor.output = presenter
        router.viewController = view
        return view
    }
}
// MARK: - Extension HomeRouterProtocol
extension HomeRouter: HomeRouterProtocol {
    func navigate(_ route: HomeRoutes) {
        guard let window = viewController?.view.window else { return }
        switch route {
        case .goDetailScreen(let idOfVideoGame):
            let sendVC = DetailVideoGameRouter.createModule()
            sendVC.presenter.setIdOfVideoGame(idOfVideoGame)
            viewController?.navigationController?.pushViewController(sendVC, animated: true)
        case .goNoInternetScreen:
            let subModules = (
                home: NoInternetRouter.createModule(),
                favorites: FavoritesRouter.createModule()
            )
            let tabBarController = TabBarRouter.createModule(usingSubModules: subModules)
            let navigationController = UINavigationController(rootViewController: tabBarController)
            window.rootViewController = navigationController
        }
    }
}
