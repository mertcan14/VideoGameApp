//
//  SplashInteractor.swift
//  VideoGameApp
//
//  Created by mertcan YAMAN on 14.07.2023.
//

import Foundation
import VideoGameAPI
// MARK: Protocol SplashInteractorProtocol
protocol SplashInteractorProtocol {
    func checkInternetConnection()
}
// MARK: Protocol SplashInteractorOutputProtocol
protocol SplashInteractorOutputProtocol {
    func returnInternetConnection(_ status: Bool)
}
// MARK: Class SplashInteractor
final class SplashInteractor {
    var output: SplashInteractorOutputProtocol?
}
// MARK: Extension SplashInteractorProtocol
extension SplashInteractor: SplashInteractorProtocol {
    func checkInternetConnection() {
        self.output?.returnInternetConnection(ReachabilityService.isConnectedToNetwork())
    }
}
