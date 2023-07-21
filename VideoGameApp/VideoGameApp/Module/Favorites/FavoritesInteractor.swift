//
//  FavoritesInteractor.swift
//  VideoGameApp
//
//  Created by mertcan YAMAN on 20.07.2023.
//

import Foundation
import MyCoreData

// MARK: Protocol FavoritesInteractorProtocol
protocol FavoritesInteractorProtocol: AnyObject {
    func fetchVideoGames()
}
// MARK: Protocol FavoritesInteractorOutputProtocol
protocol FavoritesInteractorOutputProtocol: AnyObject {
    func getVideoGames(_ videoGames: [VideoGame])
    func getError(_ error: String)
}
// MARK: Class FavoritesInteractor
final class FavoritesInteractor {
    var output: FavoritesInteractorOutputProtocol?
}
// MARK: Extension FavoritesInteractorProtocol
extension FavoritesInteractor: FavoritesInteractorProtocol {
    func fetchVideoGames() {
        MyCoreDataService.shared.getVideoGames { [weak self] result in
            switch result {
            case .success(let data):
                self?.output?.getVideoGames(data)
            case .failure(let error):
                switch error {
                case .emptyValue:
                    self?.output?.getVideoGames([])
                default:
                    self?.output?.getError(error.message ?? "Error")
                }
            }
        }
    }
}
