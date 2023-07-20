//
//  FavoritesPresenter.swift
//  VideoGameApp
//
//  Created by mertcan YAMAN on 20.07.2023.
//

import Foundation

protocol FavoritesPresenterProtocol: AnyObject {
    
}

final class FavoritesPresenter {
    unowned var view: FavoritesViewControllerProtocol
    let router: FavoritesRouterProtocol
    let interactor: FavoritesInteractorProtocol
    init(
        _ view: FavoritesViewControllerProtocol,
        _ router: FavoritesRouterProtocol,
        _ interactor: FavoritesInteractorProtocol
    ) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
}

extension FavoritesPresenter: FavoritesPresenterProtocol {
    
}

extension FavoritesPresenter: FavoritesInteractorOutputProtocol {
    
}
