//
//  HomePresenter.swift
//  VideoGameApp
//
//  Created by mertcan YAMAN on 14.07.2023.
//

import Foundation

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
    internal let router: HomeRouterProtocol
    internal let interactor: HomeInteractorProtocol
    private let slideCount: Int = 3
    private let limitNextPage: Int = 5
    private var nextPage: String?
    private var searchedVideoGame: [VideoGame] = []
    private var totalNextPage: Int = 0
    private var videoGames: [VideoGame] = [] {
        didSet {
            setImagesForSlider()
            self.view.reloadData()
            self.view.hideLoading(0.5)
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
}
// MARK: - Extension HomePresenterProtocol
extension HomePresenter: HomePresenterProtocol {
    func getInteractor() -> HomeInteractorProtocol {
        self.interactor
    }
    
    func fetchNextPage() {
        self.view.showLoading()
        if self.totalNextPage < limitNextPage, nextPage != nil {
            self.totalNextPage += 1
            self.interactor.fetchGames(nextPage)
        } else {
            self.view.hideLoading()
        }
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
        return VideoGameCellModel(imageURL: videoGame.backgroundImage?.setParseImageURL(),
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
        return VideoGameCellModel(imageURL: videoGame.backgroundImage?.setParseImageURL(),
                                  nameOfGame: videoGame.name,
                                  ratingOfGame: videoGame.rating,
                                  releasedOfGame: videoGame.released)
    }
    
    func setImagesForSlider() {
        if videoGames.count > slideCount {
            self.view.showPageView()
            self.view.setSliderImages(Array(self.videoGames.prefix(upTo: slideCount)))
        } else {
            self.view.hidePageView()
        }
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
    func goNoInternet(_ errorText: String) {
        self.view.showAlert("Connection", errorText) { [weak self] in
            self?.router.navigate(.goNoInternetScreen)
        }
    }
    
    func refreshGames(_ games: VideoGameResult) {
        guard let results = games.results else { return }
        ImageProvider.shared.refreshCache()
        self.totalNextPage = 0
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
