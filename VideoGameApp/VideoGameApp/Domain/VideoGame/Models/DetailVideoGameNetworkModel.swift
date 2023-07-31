//
//  DetailVideoGameNetworkModel.swift
//  VideoGameApp
//
//  Created by mertcan YAMAN on 31.07.2023.
//

import Foundation

// MARK: - DetailVideoGameResult
struct DetailVideoGameNetworkModel: Decodable {
    let id: Int?
    let name, description: String?
    let metacritic: Int?
    let released: String?
    let backgroundImage: String?
    let website: String?
    let rating: Double?

    enum CodingKeys: String, CodingKey {
        case id, name
        case description, metacritic
        case released
        case backgroundImage = "background_image"
        case website, rating
    }
}
