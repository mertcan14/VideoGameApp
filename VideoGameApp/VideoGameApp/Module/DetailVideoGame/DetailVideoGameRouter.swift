//
//  DetailVideoGameRouter.swift
//  VideoGameApp
//
//  Created by mertcan YAMAN on 19.07.2023.
//

import Foundation
import UIKit
// MARK: - Enum DetailVideoGameRoutes
enum DetailVideoGameRoutes {
    case goPreviousScreen
    case goNoInternetScreen
}
// MARK: - Protocol DetailVideoGameRouterProtocol
protocol DetailVideoGameRouterProtocol: AnyObject {
    func navigate(_ route: DetailVideoGameRoutes)
}
// MARK: - Class DetailVideoGameRouter
final class DetailVideoGameRouter {
    weak var viewController: DetailVideoGameViewController?
    
    static func createModule() -> DetailVideoGameViewController {
        let view = DetailVideoGameViewController()
        let router = DetailVideoGameRouter()
        let interactor = DetailVideoGameInteractor()
        let presenter = DetailVideoGamePresenter(view, router, interactor)
        view.presenter = presenter
        interactor.output = presenter
        router.viewController = view
        return view
    }
}
// MARK: - Extension DetailVideoGameRouterProtocol
extension DetailVideoGameRouter: DetailVideoGameRouterProtocol {
    func navigate(_ route: DetailVideoGameRoutes) {
        guard let window = viewController?.view.window else { return }
        switch route {
        case .goPreviousScreen:
            self.viewController?.navigationController?.popViewController(animated: true)
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
