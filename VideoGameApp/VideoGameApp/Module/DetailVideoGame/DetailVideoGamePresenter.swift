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
    var checkReleased: Bool { get }
    var checkMetacritic: Bool { get }
    
    func goBackScreen()
    func viewDidLoad()
    func setIdOfVideoGame(_ id: String)
    func likeVideoGame()
    func goWebsite()
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
        setImages()
        checkWebOfGame()
        self.view.setDescription(videoGame?.description)
        self.view.setMetacriticRate(videoGame?.metacritic)
        self.view.setGameName(videoGame?.name)
        self.view.setReleasedDate(videoGame?.released)
        self.view.hideLoading()
    }
    
    private func setImages() {
        self.view.setImageView(videoGame?.backgroundImage)
    }
    
    private func checkWebOfGame() {
        self.view.hideWebOfGameImageView(videoGame?.website == "")
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
    var checkReleased: Bool {
        if videoGame?.released == nil { return false }
        return true
    }
    
    var checkMetacritic: Bool {
        if videoGame?.metacritic == nil { return false }
        return true
    }
    
    func goWebsite() {
        guard let web = videoGame?.website,
              let url = URL(string: web) else { return }
        router.navigate(.goMetacriticSite(url: url))
    }
    
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
        self.view.showLoading()
        self.view.configBackButton()
        self.view.configLikeButton()
        self.view.configureWebOfGameImageView()
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
// MARK: - Extension DetailVideoGameInteractorOutputProtocol
extension DetailVideoGamePresenter: DetailVideoGameInteractorOutputProtocol {
    func goNoInternet(_ errorText: String) {
        self.view.showAlert("Connection", errorText) { [weak self] in
            self?.router.navigate(.goNoInternetScreen)
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
    
    func getDetailVideoGame(_ detailVideoGame: DetailVideoGame) {
        self.videoGame = detailVideoGame
    }
    
    func getError(_ errorText: String) {
        self.view.showAlert("Error", errorText, nil)
    }
}
