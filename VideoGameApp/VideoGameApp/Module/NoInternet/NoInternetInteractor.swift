//
//  NoInternetInteractor.swift
//  VideoGameApp
//
//  Created by mertcan YAMAN on 14.07.2023.
//

import Foundation
import VideoGameAPI

protocol NoInternetInteractorProtocol {
    func checkInternetConnection()
}

protocol NoInternetInteractorOutputProtocol {
    func returnInternetConnection(_ status: Bool)
}

final class NoInternetInteractor {
    var output: NoInternetInteractorOutputProtocol?
}

extension NoInternetInteractor: NoInternetInteractorProtocol {
    func checkInternetConnection() {
        self.output?.returnInternetConnection(ReachabilityService.isConnectedToNetwork())
    }
}
