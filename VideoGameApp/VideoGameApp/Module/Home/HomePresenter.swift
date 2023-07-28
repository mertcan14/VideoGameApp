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
    func goDetailScreen(_ index: Int, _ isSearching: Bool)
    func setImagesForSlider()
    func getVideoGameByIndex(_ index: Int) -> VideoGameCellModel?
    func getSearchedVideoGameByIndex(_ index: Int) -> VideoGameCellModel?
    func searchVideoGame(_ searchText: String)
    func fetchNextPage()
    func getInteractor() -> HomeInteractorProtocol
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
        guard let urlString else { return nil }
        var parsePath = urlString.split(separator: "/")
        parsePath.insert("crop/600/400", at: 3)
        parsePath[0] = "https:/"
        return parsePath.joined(separator: "/")
    }
}
// MARK: - Extension HomePresenterProtocol
extension HomePresenter: HomePresenterProtocol {
    func getInteractor() -> HomeInteractorProtocol {
        self.interactor
    }
    
    func fetchNextPage() {
        self.view.showLoading()
        self.interactor.fetchGames(nextPage)
    }
    
    func goDetailScreen(_ index: Int, _ isSearching: Bool) {
        guard let idOfVideoGame = isSearching ? self.searchedVideoGame[safe: index]?.id
                : self.videoGames[safe: index + slideCount]?.id else { return }
        self.router.navigate(.goDetailScreen(String(idOfVideoGame)))
    }
    
    var numberOfSlide: Int {
        slideCount
    }
    
    var numberOfSearchedVideoGames: Int {
        self.searchedVideoGame.count
    }
    
    func getSearchedVideoGameByIndex(_ index: Int) -> VideoGameCellModel? {
        guard let videoGame = self.searchedVideoGame[safe: index] else { return nil }
        return VideoGameCellModel(imageURL: setParseImageURL(videoGame.backgroundImage),
                                  nameOfGame: videoGame.name,
                                  ratingOfGame: videoGame.rating,
                                  releasedOfGame: videoGame.released)
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
        guard let videoGame = self.videoGames[safe: index] else { return nil }
        return VideoGameCellModel(imageURL: setParseImageURL(videoGame.backgroundImage),
                                  nameOfGame: videoGame.name,
                                  ratingOfGame: videoGame.rating,
                                  releasedOfGame: videoGame.released)
    }
    
    func setImagesForSlider() {
        self.view.setSliderImages(Array(self.videoGames.prefix(upTo: slideCount)))
    }
    
    var numberOfVideoGames: Int {
        self.videoGames.count
    }
    
    func viewDidLoad() {
        self.interactor.fetchGames(nil)
        self.view.collectionViewRegister()
        self.view.setupCollectionViewLayout()
        self.view.configFiltersButton()
    }
}
// MARK: - Extension HomeInteractorOutputProtocol
extension HomePresenter: HomeInteractorOutputProtocol {
    func refreshGames(_ games: VideoGameResult) {
        guard let results = games.results else { return }
        self.videoGames = results
        self.nextPage = games.next
    }
    
    func getError(_ errorText: String) {
        self.view.showAlert("Error", errorText, nil)
    }
    
    func getGames(_ games: VideoGameResult) {
        guard let results = games.results else { return }
        self.videoGames += results
        self.nextPage = games.next
        self.view.setPageRefreshing()
    }
}
