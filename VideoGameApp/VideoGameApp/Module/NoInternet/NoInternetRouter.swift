//
//  NoInternetRouter.swift
//  VideoGameApp
//
//  Created by mertcan YAMAN on 14.07.2023.
//

import UIKit
// MARK: - Enum NoInternetRoutes
enum NoInternetRoutes {
    case goHomeScreen
}
// MARK: - Protocol NoInternetRouterProtocol
protocol NoInternetRouterProtocol: AnyObject {
    func navigate(_ route: NoInternetRoutes)
}
// MARK: - Class NoInternetRouter
final class NoInternetRouter {
    weak var viewController: NoInternetViewController?
    
    static func createModule() -> NoInternetViewController {
        let view = NoInternetViewController()
        let router = NoInternetRouter()
        let interactor = NoInternetInteractor()
        let presenter = NoInternetPresenter(view, router, interactor)
        view.presenter = presenter
        interactor.output = presenter
        router.viewController = view
        return view
    }
}
// MARK: - Extension NoInternetRouterProtocol
extension NoInternetRouter: NoInternetRouterProtocol {
    func navigate(_ route: NoInternetRoutes) {
        guard let window = viewController?.view.window else { return }
        switch route {
        case .goHomeScreen:
            let sendVC = HomeRouter.createModule()
            let navigationController = UINavigationController(rootViewController: sendVC)
            window.rootViewController = navigationController
        }
    }
}
