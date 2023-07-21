//
//  DetailVideoGamePresenter.swift
//  VideoGameApp
//
//  Created by mertcan YAMAN on 19.07.2023.
//

import Foundation

protocol DetailVideoGamePresenterProtocol: AnyObject {
    var isLiked: Bool { get }
    
    func goBackScreen()
    func viewDidLoad()
    func setIdOfVideoGame(_ id: String)
    func likeVideoGame()
}

final class DetailVideoGamePresenter {
    unowned var view: DetailVideoGameViewControllerProtocol
    let router: DetailVideoGameRouterProtocol
    let interactor: DetailVideoGameInteractorProtocol
    var idOfVideoGame: String?
    var isLiked: Bool = false
    var videoGame: DetailVideoGame? {
        didSet {
            reloadData()
        }
    }
    init(
        _ view: DetailVideoGameViewControllerProtocol,
        _ router: DetailVideoGameRouterProtocol,
        _ interactor: DetailVideoGameInteractorProtocol
    ) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    
    private func reloadData() {
        self.view.hideLoading()
        setImages()
        guard let videoGame,
              let description = videoGame.description else { return }
        self.view.setDescription(description)
        guard let metacriticRate = videoGame.metacritic else { return }
        self.view.setMetacriticRate(String(metacriticRate))
        guard let nameOfGame = videoGame.name else { return }
        self.view.setGameName(nameOfGame)
        guard let realesedDate = videoGame.released else { return }
        self.view.setRealesedDate(realesedDate)
    }
    
    private func setImages() {
        guard let videoGame,
              let image = videoGame.backgroundImage,
              let imageURL = URL(string: image) else { return }
        self.view.setImageView(imageURL)
    }
    
    private func convertVideoGameToDict() -> [String: Any]? {
        guard let id = videoGame?.id else { return nil }
        let objDict: [String: Any] = [
            "id": id,
            "name": videoGame?.name,
            "background_image": videoGame?.backgroundImage,
            "rating": videoGame?.rating,
            "released": videoGame?.released
        ]
        return objDict
    }
}

extension DetailVideoGamePresenter: DetailVideoGamePresenterProtocol {
    func likeVideoGame() {
        if !isLiked {
            guard let objDict = convertVideoGameToDict() else { return }
            self.interactor.likedVideoGame(objDict)
        } else {
            guard let idOfVideoGame,
                  let id = Int(idOfVideoGame) else { return }
            self.interactor.unLikedVideoGame(["id": id])
        }
        
    }
    
    func viewDidLoad() {
        guard let idOfVideoGame else { return }
        self.interactor.fetchDetailVideoGameById(idOfVideoGame)
        guard let id = Int(idOfVideoGame) else { return }
        self.interactor.isLikedVideoGame(["id": id])
    }
    
    func setIdOfVideoGame(_ id: String) {
        self.idOfVideoGame = id
    }
    
    func goBackScreen() {
        router.navigate(.goPreviousScreen)
    }
}

extension DetailVideoGamePresenter: DetailVideoGameInteractorOutputProtocol {
    func getRemoveFromAddObj(_ isRemove: Bool) {
        if isRemove {
            self.isLiked = false
            self.view.unLikedVideoGame()
        }
    }
    
    func getIsLikedVideoGame(_ isLike: Bool) {
        if isLike {
            self.view.isLikedVideoGame(isLike)
            self.isLiked = true
        }
    }
    
    func getSuccessFromAddObj(_ success: Bool) {
        if success {
            self.view.likedActionSuccess()
            self.isLiked = true
        } else {
            print("Error")
        }
    }
    
    func getDetailVideoGame(_ detailVideoGame: DetailVideoGame) {
        self.videoGame = detailVideoGame
    }
    
    func getError(_ errorText: String) {
        self.view.showAlert("Error", errorText, nil)
    }
}
