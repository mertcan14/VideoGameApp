//
//  HomePresenter.swift
//  VideoGameApp
//
//  Created by mertcan YAMAN on 14.07.2023.
//

import Foundation

protocol HomePresenterProtocol: AnyObject {
    var numberOfVideoGames: Int { get }
    
    func viewDidLoad()
    func setImagesForSlider()
    func getVideoGameByIndex(_ index: Int) -> VideoGameCellModel?
}

final class HomePresenter {
    unowned var view: HomeViewControllerProtocol
    let router: HomeRouterProtocol
    let interactor: HomeInteractorProtocol
    var videoGames: [VideoGame] = [] {
        didSet {
            self.view.hideLoading()
            setImagesForSlider()
            self.view.reloadData()
        }
    }
    var nextPage: String?
    
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

extension HomePresenter: HomePresenterProtocol {
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
        var images: [String] = []
        for index in 0..<3 {
            guard let videoGame = videoGames[safe: index],
                  let image = videoGame.backgroundImage else { return }
            images.append(image)
        }
        self.view.setSliderImages(images)
    }
    
    var numberOfVideoGames: Int {
        self.videoGames.count
    }
    
    func viewDidLoad() {
        self.view.showLoading()
        self.interactor.fetchGames()
        self.view.collectionViewRegister()
    }
}

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
