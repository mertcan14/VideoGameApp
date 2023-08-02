//
//  NoInternetInteractor.swift
//  VideoGameApp
//
//  Created by mertcan YAMAN on 2.08.2023.
//

import Foundation
import VideoGameAPI
// MARK: Protocol NoInternetBusinessLogic
protocol NoInternetBusinessLogic {
    func checkInternetConnection()
}
// MARK: Protocol NoInternetDataStore
protocol NoInternetDataStore {
    
}
// MARK: Class NoInternetInteractor
final class NoInternetInteractor: NoInternetDataStore {
    var presenter: NoInternetPresentationLogic?
}
// MARK: Extension NoInternetInteractorProtocol
extension NoInternetInteractor: NoInternetBusinessLogic {
    func checkInternetConnection() {
        let response = NoInternetModels.CheckInternetConnection.Response(isConnection: ReachabilityService.isConnectedToNetwork())
        presenter?.getIsConnection(response: response)
    }
}
