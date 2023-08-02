//
//  SplashModels.swift
//  VideoGameApp
//
//  Created by mertcan YAMAN on 2.08.2023.
//

import Foundation

enum SplashModels {
    enum CheckInternetConnection {
        struct Request {}
        struct Response {
            let isConnection: Bool
        }
        struct ViewModel {
            let isConnection: Bool
        }
    }
}
