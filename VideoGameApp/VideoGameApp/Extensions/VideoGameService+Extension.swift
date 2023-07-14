//
//  VideoGameService+Extension.swift
//  VideoGameApp
//
//  Created by mertcan YAMAN on 13.07.2023.
//

import Foundation
import VideoGameAPI

extension NetworkService {
    func getListVideoGame(
        params: [String: String]? = nil,
        completion: @escaping ((Result<GetListVideoGameRequest.Response, NetworkError>) -> Void)
    ) {
        if ReachabilityService.isConnectedToNetwork() {
            let request = GetListVideoGameRequest()
            self.fetchFromAPI(request, completion: completion)
        } else {
            completion(.failure(.connectionError))
        }
    }
    
    func getDetailVideoGame(
        idOfGame: String,
        params: [String: String]? = nil,
        completion: @escaping ((Result<GetDetailVideoGameRequest.Response, NetworkError>) -> Void)
    ) {
        if ReachabilityService.isConnectedToNetwork() {
            let request = GetDetailVideoGameRequest(idOfGame: idOfGame)
            self.fetchFromAPI(request, completion: completion)
        } else {
            completion(.failure(.connectionError))
        }
    }
}
