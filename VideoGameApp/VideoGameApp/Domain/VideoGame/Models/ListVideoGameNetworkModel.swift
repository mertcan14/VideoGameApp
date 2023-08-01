//
//  ListVideoGameNetworkModel.swift
//  VideoGameApp
//
//  Created by mertcan YAMAN on 31.07.2023.
//

import Foundation

// MARK: - VideoGameResult
struct ListVideoGameNetworkModel: Decodable {
    let count: Int?
    let next: String?
    let previous: String?
    var results: [VideoGameNetworkModel]?

    enum CodingKeys: String, CodingKey {
        case count, next, previous, results
    }
}

// MARK: - VideoGame
struct VideoGameNetworkModel: Decodable {
    let id: Int?
    let name, released: String?
    var backgroundImage: String?
    let rating: Double?
    let metacritic: Int?
    let parentPlatforms: [ParentPlatformNetworkModel]?

    enum CodingKeys: String, CodingKey {
        case id, name, released
        case backgroundImage = "background_image"
        case rating
        case metacritic
        case parentPlatforms = "parent_platforms"
    }
}

// MARK: - Platform
struct PlatformNetworkModel: Decodable {
    let id: Int?
    let name, slug: String?
}

// MARK: - ParentPlatform
struct ParentPlatformNetworkModel: Decodable {
    let platform: PlatformNetworkModel?
}
