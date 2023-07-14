//
//  NoInternetRouter.swift
//  VideoGameApp
//
//  Created by mertcan YAMAN on 14.07.2023.
//

import Foundation

enum NoInternetRoutes {
    case goHomeScreen
}

protocol NoInternetRouterProtocol: AnyObject {
    func navigate(_ route: NoInternetRoutes)
}

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

extension NoInternetRouter: NoInternetRouterProtocol {
    func navigate(_ route: NoInternetRoutes) {
        switch route {
        case .goHomeScreen:
            print("go Home")
        }
    }
}
