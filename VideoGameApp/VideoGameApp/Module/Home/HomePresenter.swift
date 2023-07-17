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
}

final class HomePresenter {
    unowned var view: HomeViewControllerProtocol
    let router: HomeRouterProtocol
    let interactor: HomeInteractorProtocol
    var videoGames: [VideoGame] = [] {
        didSet {
            self.view.hideLoading()
            setImagesForSlider()
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
}

extension HomePresenter: HomePresenterProtocol {
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
