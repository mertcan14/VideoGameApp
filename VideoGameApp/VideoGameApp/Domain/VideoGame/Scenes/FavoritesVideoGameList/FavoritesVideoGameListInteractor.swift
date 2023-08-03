//
//  FavoritesVideoGameListInteractor.swift
//  VideoGameApp
//
//  Created by mertcan YAMAN on 2.08.2023.
//

import VideoGameAPI
import MyCoreData

protocol FavoritesVideoGameListBusinessLogic {
    func fetchFavoritesVideoGameList()
    func setGameId(_ id: String)
}

protocol FavoritesVideoGameListDataStore {
    var gameID: String { get set }
}

final class FavoritesVideoGameListInteractor: FavoritesVideoGameListDataStore {
    var gameID: String = ""
    var presenter: FavoritesVideoGameListPresentationLogic?
}

extension FavoritesVideoGameListInteractor: FavoritesVideoGameListBusinessLogic {
    func setGameId(_ id: String) {
        gameID = id
    }
    
    func fetchFavoritesVideoGameList() {
        MyCoreDataService.shared.getVideoGames { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let data):
                let response = FavoritesVideoGameList.FetchVideoGameListFromCoreData.Response(videoGameResult: data)
                self.presenter?.presentFavoritesVideoGameList(response: response)
            case .failure(let error):
                if error.message == CoreDataError.emptyValue.message {
                    self.presenter?.getEmptyValue()
                } else {
                    self.presenter?.getError(content: error.message ?? "")
                }
            }
        }
    }
}
