//
//  FavoritesPresenter.swift
//  VideoGameApp
//
//  Created by mertcan YAMAN on 20.07.2023.
//

import Foundation

protocol FavoritesPresenterProtocol: AnyObject {
    func viewDidLoad()
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
    func viewDidLoad() {
        self.view.showLoading()
        self.interactor.fetchVideoGames()
    }
}

extension FavoritesPresenter: FavoritesInteractorOutputProtocol {
    func getVideoGames(_ videoGames: [VideoGame]) {
        self.view.hideLoading()
    }
    
    func getError(_ error: String) {
        self.view.showAlert("Error", error, nil)
    }
}
