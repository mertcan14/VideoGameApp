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
    
    private func setParseImageURL(_ urlString: String?) -> String? {
        guard let url = urlString else { return nil }
        var parseUrl = url.split(separator: "/")
        parseUrl.insert("crop/600/400", at: 3)
        return parseUrl.joined(separator: "/")
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
        guard let videoGame = self.videoGames[safe: index],
              let nameOfGame = videoGame.name,
              let ratingOfGame = videoGame.rating,
              let releasedOfGame = videoGame.released,
              let imageString = setParseImageURL(videoGame.backgroundImage),
              let imageURL = URL(string: imageString) else { return nil }
        return VideoGameCellModel(imageURL: imageURL, nameOfGame: nameOfGame, ratingOfGame: ratingOfGame, releasedOfGame: releasedOfGame)
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
