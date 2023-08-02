//
//  VideoGameDetailInteractor.swift
//  VideoGameApp
//
//  Created by mertcan YAMAN on 2.08.2023.
//

import VideoGameAPI
import MyCoreData

protocol VideoGameDetailBusinessLogic {
    func fetchVideoGameDetail()
    func fetchIsLikeVideoGame()
}

protocol VideoGameDetailDataStore {
    var gameID: String { get set }
}

final class VideoGameDetailInteractor: VideoGameDetailDataStore {
    var gameID: String = ""
    private let entityName = "SavedVideoGame"
    private let optinalErrorMessage = "Error"
    
    var presenter: VideoGameDetailPresentationLogic?
}

extension VideoGameDetailInteractor: VideoGameDetailBusinessLogic {
    func fetchIsLikeVideoGame() {
        guard let persistentContainer = CoreDataReturnPersistentContainer.shared.persistentContainer else { return }
        MyCoreDataService.shared.checkObject(persistentContainer,
                                             entityName: entityName,
                                             checkAttribute: ["id": gameID]) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let isLike):
                presenter?.getIsLikedVideoGame(response: VideoGameDetailModels.FetchIsLikedVideoGame.Response(isLike: isLike))
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func fetchVideoGameDetail() {
        NetworkService.shared.fetchFromAPI(GetDetailVideoGameRequest(idOfGame: self.gameID)) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let data):
                let response = VideoGameDetailModels.FetchVideoGameDetail.Response(videoGameResult: data)
                self.presenter?.presentVideoGameDetail(response: response)
            case .failure(let error):
                print(error)
            }
        }
    }
}
