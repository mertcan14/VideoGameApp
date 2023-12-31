//
//  SplashRouter.swift
//  VideoGameApp
//
//  Created by mertcan YAMAN on 14.07.2023.
//
import UIKit
// MARK: - Enum SplashRoutes
enum SplashRoutes {
    case homeScreen
    case noInternetScreen
}
// MARK: - Protocol SplashRouterProtocol
protocol SplashRouterProtocol: AnyObject {
    func navigate(_ route: SplashRoutes)
}
// MARK: - Class SplashRouter
final class SplashRouter {
    weak var viewController: SplashViewController?
    
    static func createModule() -> SplashViewController {
        let view = SplashViewController()
        let interactor = SplashInteractor()
        let router = SplashRouter()
        let presenter = SplashPresenter(view, router, interactor)
        view.presenter = presenter
        interactor.output = presenter
        router.viewController = view
        return view
    }
}
// MARK: - Extension SplashRouterProtocol
extension SplashRouter: SplashRouterProtocol {
    func navigate(_ route: SplashRoutes) {
        guard let window = viewController?.view.window else { return }
        switch route {
        case .homeScreen:
            let subModules = (
                home: HomeRouter.createModule(),
                favorites: FavoritesRouter.createModule()
            )
            let tabBarController = TabBarRouter.createModule(usingSubModules: subModules)
            let navigationController = UINavigationController(rootViewController: tabBarController)
            window.rootViewController = navigationController
        case .noInternetScreen:
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
