//
//  VideoGameDetailModels.swift
//  VideoGameApp
//
//  Created by mertcan YAMAN on 2.08.2023.
//

import Foundation

enum VideoGameDetailModels {
    enum FetchVideoGameDetail {
        struct Request {}
        struct Response {
            var videoGameResult: DetailVideoGameNetworkModel?
        }
        struct ViewModel {
            let results: DetailVideoGameNetworkModel?
        }
    }
    
    enum FetchIsLikedVideoGame {
        struct Request {}
        struct Response {
            var isLike: Bool
        }
        struct ViewModel {
            let isLike: Bool
        }
    }
    
    enum DeleteSavedVideoGame {
        struct Request {}
        struct Response {
            let isDelete: Bool
        }
        struct ViewModel {
            let isDelete: Bool
        }
    }
    
    enum SaveVideoGame {
        struct Request {
            let obj: [String: Any]
        }
        struct Response {
            let isLike: Bool
        }
        struct ViewModel {
            let isLike: Bool
        }
    }
}
