//
//  SplashPresenter.swift
//  VideoGameApp
//
//  Created by mertcan YAMAN on 14.07.2023.
//

import Foundation

protocol SplashPresenterProtocol: AnyObject {
    func viewDidAppear()
}

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

extension SplashPresenter: SplashInteractorOutputProtocol {
    func returnInternetConnection(_ status: Bool) {
        if status {
            view.delay(1.0) {
                self.router.navigate(.homeScreen)
            }
        } else {
            view.delay(1.0) {
                self.router.navigate(.noInternetScreen)
            }
        }
    }
}
