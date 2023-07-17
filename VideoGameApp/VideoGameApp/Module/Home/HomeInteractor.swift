//
//  HomeInteractor.swift
//  VideoGameApp
//
//  Created by mertcan YAMAN on 14.07.2023.
//

import Foundation
import VideoGameAPI

protocol HomeInteractorProtocol: AnyObject {
    func fetchGames()
}

protocol HomeInteractorOutputProtocol: AnyObject {
    func getGames(_ games: VideoGameResult)
    func getError(_ errorText: String)
}

final class HomeInteractor {
    var output: HomeInteractorOutputProtocol?
}

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
