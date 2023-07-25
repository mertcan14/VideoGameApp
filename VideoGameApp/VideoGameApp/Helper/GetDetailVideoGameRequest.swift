//
//  GetDetailVideoGameRequest.swift
//  VideoGameApp
//
//  Created by mertcan YAMAN on 13.07.2023.
//

import Foundation
import VideoGameAPI

struct GetDetailVideoGameRequest: BaseRequestProtocol {
    typealias Response = DetailVideoGame
    private let apiKey: String = "2b4634cc446c49fe81e0ad55b7ad042c"
    var headers: [String: String] = [:]
    var idOfGame: String
    var urlConst: String?
    
    var url: String {
        let baseURL: String = "https://api.rawg.io"
        let path: String = "/api/games/"
        return baseURL + path + idOfGame
    }
    
    var queryItems: [String: String] {
        [
            "key": apiKey
        ]
    }
    
    var method: HTTPMethod {
        .get
    }
    
    func decode(_ data: Data) throws -> DetailVideoGame {
        let decoder = JSONDecoder()
        let response = try decoder.decode(DetailVideoGame.self, from: data)
        return response
    }
}
