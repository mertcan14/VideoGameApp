//
//  DetailVideoGameInteractor.swift
//  VideoGameApp
//
//  Created by mertcan YAMAN on 19.07.2023.
//

import Foundation
import VideoGameAPI
import MyCoreData
// MARK: - Protocol DetailVideoGameInteractorProtocol
protocol DetailVideoGameInteractorProtocol {
    func fetchDetailVideoGameById(_ id: String)
    func likedVideoGame(_ addObj: [String: Any])
    func unLikedVideoGame(_ removeObj: [String: Any])
    func isLikedVideoGame(_ addObj: [String: Any])
}
// MARK: - Protocol DetailVideoGameInteractorOutputProtocol
protocol DetailVideoGameInteractorOutputProtocol {
    func getDetailVideoGame(_ detailVideoGame: DetailVideoGame)
    func getSuccessFromAddObj(_ success: Bool)
    func getRemoveFromAddObj(_ isRemove: Bool)
    func getIsLikedVideoGame(_ isLike: Bool)
    func getError(_ errorText: String)
}
// MARK: - Class DetailVideoGameInteractor
final class DetailVideoGameInteractor {
    var output: DetailVideoGameInteractorOutputProtocol?
    var persistentContainer = CoreDataReturnPersistentContainer.shared.persistentContainer
}
// MARK: - Extension DetailVideoGameInteractorProtocol
extension DetailVideoGameInteractor: DetailVideoGameInteractorProtocol {
    func unLikedVideoGame(_ removeObj: [String: Any]) {
        guard let persistentContainer else { return }
        MyCoreDataService.shared.deleteObj(persistentContainer,
                                           entityName: "SavedVideoGame",
                                           removeObj) { result in
            switch result {
            case .success(let isRemove):
                self.output?.getRemoveFromAddObj(isRemove)
            case .failure(let error):
                self.output?.getError(error.message ?? "Error")
            }
        }
    }
    
    func isLikedVideoGame(_ addObj: [String: Any]) {
        guard let persistentContainer else { return }
        MyCoreDataService.shared.checkObject(persistentContainer,
                                             entityName: "SavedVideoGame",
                                             checkAttribute: addObj) { [weak self] result in
            switch result {
            case .success(let isLike):
                self?.output?.getIsLikedVideoGame(isLike)
            case .failure(let error):
                self?.output?.getError(error.message ?? "Error")
            }
        }
    }
    
    func likedVideoGame(_ addObj: [String: Any]) {
        guard let persistentContainer else { return }
        MyCoreDataService.shared.addObj(persistentContainer: persistentContainer,
                                        entityName: "SavedVideoGame",
                                        addObj: addObj) { [weak self] result in
            switch result {
            case .success(let success):
                self?.output?.getSuccessFromAddObj(success)
            case .failure(let error):
                self?.output?.getError(error.message ?? "Error")
            }
        }
    }
    
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
