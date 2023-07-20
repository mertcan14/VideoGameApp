//
//  FavoritesInteractor.swift
//  VideoGameApp
//
//  Created by mertcan YAMAN on 20.07.2023.
//

import Foundation
import MyCoreData

protocol FavoritesInteractorProtocol: AnyObject {
    func fetchVideoGames()
    func addVideoGame()
}

protocol FavoritesInteractorOutputProtocol: AnyObject {
    func getVideoGames(_ videoGames: [VideoGame])
    func getError(_ error: String)
}

final class FavoritesInteractor {
    var output: FavoritesInteractorOutputProtocol?
}

extension FavoritesInteractor: FavoritesInteractorProtocol {
    func addVideoGame() {
        guard let persistentContainer = CoreDataReturnPersistentContainer.shared.persistentContainer else { return }
        let addObj: [String: Any] = [
            "id": 1,
            "name": "Mertcan",
            "background_image": "image",
            "rating": 4.4,
            "released": "1999"
        ]
        MyCoreDataService.shared.addObj(persistentContainer: persistentContainer,
                                        entityName: "SavedVideoGame",
                                        addObj: addObj) { [weak self] result in
            switch result {
            case .success(let data):
                print(data)
            case .failure(let error):
                self?.output?.getError(error.message ?? "Error")
            }
        }
    }
    
    func fetchVideoGames() {
        MyCoreDataService.shared.getVideoGames { [weak self] result in
            switch result {
            case .success(let data):
                self?.output?.getVideoGames(data)
            case .failure(let error):
                self?.output?.getError(error.message ?? "Error")
            }
        }
    }
}
