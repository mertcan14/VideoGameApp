//
//  BaseInteractor.swift
//  VideoGameApp
//
//  Created by mertcan YAMAN on 26.07.2023.
//

import Foundation
import VideoGameAPI

protocol BaseInteractorOutputProtocol {
    func getError(_ errorText: String)
    func goNoInternet(_ errorText: String)
}

class BaseInteractor {
    func checkInternet(_ error: String) -> Bool {
        if error == NetworkError.connectionError.message {
            return false
        } else {
            return true
        }
    }
}
