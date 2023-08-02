//
//  FavoritesVideoGameListModels.swift
//  VideoGameApp
//
//  Created by mertcan YAMAN on 2.08.2023.
//

import Foundation

enum FavoritesVideoGameList {
    enum FetchVideoGameListFromCoreData {
        struct Request {}
        struct Response {
            var videoGameResult: [VideoGameNetworkModel]?
        }
        struct ViewModel {
            let results: [VideoGameNetworkModel]?
        }
    }
}
