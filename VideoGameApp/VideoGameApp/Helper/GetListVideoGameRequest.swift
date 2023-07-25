//
//  GetListVideoGameRequest.swift
//  VideoGameApp
//
//  Created by mertcan YAMAN on 13.07.2023.
//

import Foundation
import VideoGameAPI

struct GetListVideoGameRequest: BaseRequestProtocol {
    typealias Response = VideoGameResult
    var headers: [String: String] = [:]
    var urlConst: String?
    
    private let apiKey: String = "2b4634cc446c49fe81e0ad55b7ad042c"

    var url: String {
        let baseURL: String = "https://api.rawg.io"
        let path: String = "/api/games"
        return baseURL + path
    }
    
    var queryItems: [String: String] {
        [
            "key": apiKey
        ]
    }
    
    var method: HTTPMethod {
        .get
    }
    
    func decode(_ data: Data) throws -> VideoGameResult {
        let decoder = JSONDecoder()        
        let response = try decoder.decode(VideoGameResult.self, from: data)
        return response
    }
}
