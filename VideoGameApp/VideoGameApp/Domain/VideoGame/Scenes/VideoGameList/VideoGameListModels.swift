//
//  VideoGameListModels.swift
//  VideoGameApp
//
//  Created by mertcan YAMAN on 31.07.2023.
//

import UIKit

enum VideoGameList {
    enum FetchVideoGameList {
        struct Request {}
        struct Response {
            let videoGameResult: ListVideoGameNetworkModel
        }
        struct ViewModel {
            let next: String?
            let results: [VideoGameNetworkModel]?
        }
    }
}
