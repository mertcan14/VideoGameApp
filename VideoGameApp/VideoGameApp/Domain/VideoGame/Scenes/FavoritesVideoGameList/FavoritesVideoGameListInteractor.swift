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
}

protocol FavoritesVideoGameListDataStore {
    
}

final class FavoritesVideoGameListInteractor: FavoritesVideoGameListDataStore {
    var presenter: FavoritesVideoGameListPresentationLogic?
}

extension FavoritesVideoGameListInteractor: FavoritesVideoGameListBusinessLogic {
    func fetchFavoritesVideoGameList() {
        MyCoreDataService.shared.getVideoGames { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let data):
                let response = FavoritesVideoGameList.FetchVideoGameListFromCoreData.Response(videoGameResult: data)
                self.presenter?.presentFavoritesVideoGameList(response: response)
            case .failure(let error):
                print(error)
            }
        }
    }
}
