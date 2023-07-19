//
//  HomeInteractor.swift
//  VideoGameApp
//
//  Created by mertcan YAMAN on 14.07.2023.
//

import Foundation
import VideoGameAPI
// MARK: - Protocol HomeInteractorProtocol
protocol HomeInteractorProtocol: AnyObject {
    func fetchGames()
}
// MARK: - Protocol HomeInteractorOutputProtocol
protocol HomeInteractorOutputProtocol: AnyObject {
    func getGames(_ games: VideoGameResult)
    func getError(_ errorText: String)
}
// MARK: - Class HomeInteractor
final class HomeInteractor {
    var output: HomeInteractorOutputProtocol?
}
// MARK: - Extension HomeInteractorProtocol
extension HomeInteractor: HomeInteractorProtocol {
    func fetchGames() {
        NetworkService.shared.getListVideoGame { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let games):
                self.output?.getGames(games)
            case .failure(let error):
                self.output?.getError(error.message ?? "Error")
            }
        }
    }
}
