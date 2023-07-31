//
//  VideoGameModel.swift
//  VideoGameApp
//
//  Created by mertcan YAMAN on 13.07.2023.
//

import Foundation

// MARK: - VideoGameResult
struct VideoGameResult: Decodable {
    let count: Int?
    let next: String?
    let previous: String?
    let results: [VideoGame]?

    enum CodingKeys: String, CodingKey {
        case count, next, previous, results
    }
}

// MARK: - VideoGame
struct VideoGame: Decodable {
    let id: Int?
    let name, released: String?
    let backgroundImage: String?
    let rating: Double?
    let metacritic: Int?
    let parentPlatforms: [ParentPlatform]?

    enum CodingKeys: String, CodingKey {
        case id, name, released
        case backgroundImage = "background_image"
        case rating
        case metacritic
        case parentPlatforms = "parent_platforms"
    }
}

// MARK: - Platform
struct Platform: Decodable {
    let id: Int?
    let name, slug: String?
}

// MARK: - ParentPlatform
struct ParentPlatform: Decodable {
    let platform: Platform?
}

// MARK: - ShortScreenshot
struct ShortScreenshot: Decodable {
    let id: Int?
    let image: String?
}
