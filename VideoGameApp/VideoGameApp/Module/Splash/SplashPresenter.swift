//
//  SplashPresenter.swift
//  VideoGameApp
//
//  Created by mertcan YAMAN on 14.07.2023.
//

import Foundation
// MARK: Protocol SplashPresenterProtocol
protocol SplashPresenterProtocol: AnyObject {
    func viewDidAppear()
}
// MARK: Class SplashPresenter
final class SplashPresenter: SplashPresenterProtocol {
    unowned var view: BaseViewControllerProtocol
    let router: SplashRouterProtocol
    let interactor: SplashInteractorProtocol
    
    init(
        _ view: BaseViewControllerProtocol,
        _ router: SplashRouterProtocol,
        _ interactor: SplashInteractorProtocol
    ) {
        self.interactor = interactor
        self.router = router
        self.view = view
    }
    
    func viewDidAppear() {
        interactor.checkInternetConnection()
    }
}
// MARK: Extension SplashInteractorOutputProtocol
extension SplashPresenter: SplashInteractorOutputProtocol {
    func returnInternetConnection(_ status: Bool) {
        view.delay(1.0) { [weak self] in
            guard let self = self else { return }
            self.router.navigate(status ? .homeScreen : .noInternetScreen)
        }
    }
}
