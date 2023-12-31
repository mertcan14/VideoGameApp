//
//  FavoritesPresenter.swift
//  VideoGameApp
//
//  Created by mertcan YAMAN on 20.07.2023.
//

import Foundation
// MARK: Protocol FavoritesPresenterProtocol
protocol FavoritesPresenterProtocol: AnyObject {
    var numberOfVideoGame: Int { get }
    
    func getVideoGameByIndex(_ index: Int) -> VideoGameCellModel?
    func viewDidLoad()
    func viewWillAppear()
    func goDetailScreen(_ index: Int)
}
// MARK: Class FavoritesPresenter
final class FavoritesPresenter {
    unowned var view: FavoritesViewControllerProtocol
    let router: FavoritesRouterProtocol
    let interactor: FavoritesInteractorProtocol
    var videoGames: [VideoGame] = []
    
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
// MARK: Extension FavoritesPresenterProtocol
extension FavoritesPresenter: FavoritesPresenterProtocol {
    func goDetailScreen(_ index: Int) {
        guard let idOfVideoGame = self.videoGames[safe: index]?.id else { return }
        self.router.navigate(.goDetailScreen(String(idOfVideoGame)))
    }
    
    func viewWillAppear() {
        self.view.showLoading()
        self.interactor.fetchVideoGames()
    }
    
    func getVideoGameByIndex(_ index: Int) -> VideoGameCellModel? {
        guard let videoGame = self.videoGames[safe: index] else { return nil }
        return VideoGameCellModel(imageURL: videoGame.backgroundImage?.setParseImageURL(),
                                  nameOfGame: videoGame.name,
                                  ratingOfGame: videoGame.rating,
                                  releasedOfGame: videoGame.released)
    }
    
    var numberOfVideoGame: Int {
        videoGames.count
    }
    
    func viewDidLoad() {
        self.view.collectionViewRegister()
        self.view.setupCollectionViewLayout()
    }
}
// MARK: Extension FavoritesInteractorOutputProtocol
extension FavoritesPresenter: FavoritesInteractorOutputProtocol {
    func getVideoGames(_ videoGames: [VideoGame]) {
        self.view.hideLoading()
        self.videoGames = videoGames
        self.view.reloadData()
    }
    
    func getError(_ error: String) {
        self.view.showAlert("Error", error, nil)
    }
}
