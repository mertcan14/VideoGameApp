//
//  DetailVideoGameInteractor.swift
//  VideoGameApp
//
//  Created by mertcan YAMAN on 19.07.2023.
//

import Foundation
import VideoGameAPI
// MARK: - Protocol DetailVideoGameInteractorProtocol
protocol DetailVideoGameInteractorProtocol {
    func fetchDetailVideoGameById(_ id: String)
}
// MARK: - Protocol DetailVideoGameInteractorOutputProtocol
protocol DetailVideoGameInteractorOutputProtocol {
    func getDetailVideoGame(_ detailVideoGame: DetailVideoGame)
    func getError(_ errorText: String)
}
// MARK: - Class DetailVideoGameInteractor
final class DetailVideoGameInteractor {
    var output: DetailVideoGameInteractorOutputProtocol?
}
// MARK: - Extension DetailVideoGameInteractorProtocol
extension DetailVideoGameInteractor: DetailVideoGameInteractorProtocol {
    func fetchDetailVideoGameById(_ id: String) {
        NetworkService.shared.getDetailVideoGame(idOfGame: id) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let videoGame):
                self.output?.getDetailVideoGame(videoGame)
            case .failure(let error):
                self.output?.getError(error.message ?? "Error")
            }
        }
    }
}
