//
//  HomeRouter.swift
//  VideoGameApp
//
//  Created by mertcan YAMAN on 14.07.2023.
//

import UIKit
// MARK: - Enum HomeRoutes
enum HomeRoutes {
    case goDetailScreen
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
        switch route {
        case .goDetailScreen:
            print("go detail page")
        }
    }
}
