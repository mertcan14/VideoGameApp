//
//  SplashInteractor.swift
//  VideoGameApp
//
//  Created by mertcan YAMAN on 14.07.2023.
//

import Foundation
import VideoGameAPI
// MARK: Protocol SplashInteractorBusinessLogic
protocol SplashBusinessLogic {
    func checkInternetConnection()
}
// MARK: Protocol SplashInteractorDataStore
protocol SplashDataStore {
    
}
// MARK: Class SplashInteractor
final class SplashInteractor: SplashDataStore {
    var presenter: SplashPresentationLogic?
}
// MARK: Extension SplashInteractorProtocol
extension SplashInteractor: SplashBusinessLogic {
    func checkInternetConnection() {
        let response = SplashModels.CheckInternetConnection.Response(isConnection: ReachabilityService.isConnectedToNetwork())
        presenter?.getIsConnection(response: response)
    }
}
