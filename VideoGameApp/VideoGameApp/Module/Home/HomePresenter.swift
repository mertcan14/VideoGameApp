//
//  HomePresenter.swift
//  VideoGameApp
//
//  Created by mertcan YAMAN on 14.07.2023.
//

import Foundation

private let slideCount: Int = 3
// MARK: Protocol HomePresenterProtocol
protocol HomePresenterProtocol: AnyObject {
    var numberOfVideoGames: Int { get }
    var numberOfSearchedVideoGames: Int { get }
    var numberOfSlide: Int { get }
    
    func viewDidLoad()
    func setImagesForSlider()
    func getVideoGameByIndex(_ index: Int) -> VideoGameCellModel?
    func getSearchedVideoGameByIndex(_ index: Int) -> VideoGameCellModel?
    func searchVideoGame(_ searchText: String)
}
// MARK: Class HomePresenter
final class HomePresenter {
    unowned var view: HomeViewControllerProtocol
    let router: HomeRouterProtocol
    let interactor: HomeInteractorProtocol
    var nextPage: String?
    var searchedVideoGame: [VideoGame] = []
    var videoGames: [VideoGame] = [] {
        didSet {
            self.view.hideLoading()
            setImagesForSlider()
            self.view.reloadData()
        }
    }
    
    init(
        _ view: HomeViewControllerProtocol,
        _ router: HomeRouterProtocol,
        _ interactor: HomeInteractorProtocol
    ) {
        self.interactor = interactor
        self.router = router
        self.view = view
    }
    
    private func setParseImageURL(_ urlString: String?) -> String? {
        guard let url = urlString else { return nil }
        var parseUrl = url.split(separator: "/")
        parseUrl.insert("crop/600/400", at: 3)
        return parseUrl.joined(separator: "/")
    }
}
// MARK: - Extension HomePresenterProtocol
extension HomePresenter: HomePresenterProtocol {
    var numberOfSlide: Int {
        slideCount
    }
    
    var numberOfSearchedVideoGames: Int {
        self.searchedVideoGame.count
    }
    
    func getSearchedVideoGameByIndex(_ index: Int) -> VideoGameCellModel? {
        guard let videoGame = self.searchedVideoGame[safe: index],
              let nameOfGame = videoGame.name,
              let ratingOfGame = videoGame.rating,
              let releasedOfGame = videoGame.released,
              let imageString = setParseImageURL(videoGame.backgroundImage),
              let imageURL = URL(string: imageString) else { return nil }
        return VideoGameCellModel(imageURL: imageURL, nameOfGame: nameOfGame, ratingOfGame: ratingOfGame, releasedOfGame: releasedOfGame)
    }
    
    func searchVideoGame(_ searchText: String) {
        searchedVideoGame = []
        videoGames.forEach { [weak self] videoGame in
            guard let name = videoGame.name else { return }
            if name.lowercased().contains(searchText) {
                self?.searchedVideoGame.append(videoGame)
            }
        }
        self.view.reloadData()
        self.view.hidePageView()    
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
    
    func setImagesForSlider() {
        self.view.setSliderImages(Array(self.videoGames.prefix(upTo: slideCount)))
    }
    
    var numberOfVideoGames: Int {
        self.videoGames.count
    }
    
    func viewDidLoad() {
        self.view.showLoading()
        self.interactor.fetchGames()
        self.view.collectionViewRegister()
        self.view.setupCollectionViewLayout()
    }
}
// MARK: - Extension HomeInteractorOutputProtocol
extension HomePresenter: HomeInteractorOutputProtocol {
    func getError(_ errorText: String) {
        self.view.showAlert("Error", errorText, nil)
    }
    
    func getGames(_ games: VideoGameResult) {
        guard let results = games.results else { return }
        self.videoGames = results
        self.nextPage = games.next
    }
}
