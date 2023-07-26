//
//  DetailVideoGamePresenter.swift
//  VideoGameApp
//
//  Created by mertcan YAMAN on 19.07.2023.
//

import Foundation
// MARK: - Protocol DetailVideoGamePresenterProtocol
protocol DetailVideoGamePresenterProtocol: AnyObject {
    var isLiked: Bool { get }
    
    func goBackScreen()
    func viewDidLoad()
    func setIdOfVideoGame(_ id: String)
    func likeVideoGame()
}
// MARK: - Class DetailVideoGamePresenter
final class DetailVideoGamePresenter {
    // MARK: - Variable Definitions
    internal unowned var view: DetailVideoGameViewControllerProtocol
    internal let router: DetailVideoGameRouterProtocol
    internal let interactor: DetailVideoGameInteractorProtocol
    private var idOfVideoGame: String?
    internal var isLiked: Bool = false
    private(set) var videoGame: DetailVideoGame? {
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
    // MARK: - Private Funcs
    private func reloadData() {
        self.view.hideLoading()
        setImages()
        self.view.setDescription(videoGame?.description)
        self.view.setMetacriticRate(String(videoGame?.metacritic ?? 0))
        self.view.setGameName(videoGame?.name)
        self.view.setReleasedDate(videoGame?.released)
    }
    
    private func setImages() {
        self.view.setImageView(videoGame?.backgroundImage)
    }
    
    private func convertVideoGameToDict() -> [String: Any]? {
        guard let id = videoGame?.id else { return nil }
        let objDict: [String: Any] = [
            "id": id,
            "name": videoGame?.name ?? "",
            "background_image": videoGame?.backgroundImage ?? "",
            "rating": videoGame?.rating ?? 0.0,
            "released": videoGame?.released ?? ""
        ]
        return objDict
    }
}
// MARK: - Extension DetailVideoGamePresenterProtocol
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
        self.view.configBackButton()
        self.view.configLikeButton()
        guard let idOfVideoGame else { return }
        self.view.showLoading()
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
// MARK: - Extension DetailVideoGameInteractorOutputProtocol
extension DetailVideoGamePresenter: DetailVideoGameInteractorOutputProtocol {
    func goNoInternet(_ errorText: String) {
        self.view.showAlert("Connection", errorText) {
            self.router.navigate(.goNoInternetScreen)
        }
    }
    
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
    // TODO: getSuccessFromAddObj == getIsLikedVideoGame
    func getSuccessFromAddObj(_ success: Bool) {
        if success {
            self.view.isLikedVideoGame(true)
            self.isLiked = true
        }
    }
    
    func getDetailVideoGame(_ detailVideoGame: DetailVideoGame) {
        self.videoGame = detailVideoGame
    }
    
    func getError(_ errorText: String) {
        self.view.showAlert("Error", errorText, nil)
    }
}
