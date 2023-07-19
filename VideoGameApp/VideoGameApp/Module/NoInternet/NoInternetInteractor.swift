//
//  NoInternetInteractor.swift
//  VideoGameApp
//
//  Created by mertcan YAMAN on 14.07.2023.
//

import Foundation
import VideoGameAPI
// MARK: - Protocol NoInternetInteractorProtocol
protocol NoInternetInteractorProtocol {
    func checkInternetConnection()
}
// MARK: - Protocol NoInternetInteractorOutputProtocol
protocol NoInternetInteractorOutputProtocol {
    func returnInternetConnection(_ status: Bool)
}
// MARK: - Class NoInternetInteractor
final class NoInternetInteractor {
    var output: NoInternetInteractorOutputProtocol?
}
// MARK: - Extension NoInternetInteractorProtocol
extension NoInternetInteractor: NoInternetInteractorProtocol {
    func checkInternetConnection() {
        self.output?.returnInternetConnection(ReachabilityService.isConnectedToNetwork())
    }
}
