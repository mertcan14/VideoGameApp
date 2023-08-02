//
//  MyCoreDataService+Extension.swift
//  VideoGameApp
//
//  Created by mertcan YAMAN on 20.07.2023.
//

import Foundation
import MyCoreData

extension MyCoreDataService {
    func getVideoGames(completion: @escaping (Result<[VideoGameNetworkModel], CoreDataError>) -> Void) {
        guard let persistentContainer = CoreDataReturnPersistentContainer.shared.persistentContainer else { return }
        self.fetchData(persistentContainer, entityName: "SavedVideoGame", completion: completion)
    }
}
