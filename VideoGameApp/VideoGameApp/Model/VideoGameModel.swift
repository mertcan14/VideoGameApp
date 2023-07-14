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
    let slug, name, released: String?
    let backgroundImage: String?
    let rating: Double?
    let ratingTop: Int?
    let ratingsCount, reviewsTextCount: Int?
    let metacritic, playtime: Int?
    let reviewsCount: Int?
    let saturatedColor, dominantColor: String?
    let parentPlatforms: [ParentPlatform]?
    let shortScreenshots: [ShortScreenshot]?

    enum CodingKeys: String, CodingKey {
        case id, slug, name, released
        case backgroundImage = "background_image"
        case rating
        case ratingTop = "rating_top"
        case ratingsCount = "ratings_count"
        case reviewsTextCount = "reviews_text_count"
        case metacritic, playtime
        case reviewsCount = "reviews_count"
        case saturatedColor = "saturated_color"
        case dominantColor = "dominant_color"
        case parentPlatforms = "parent_platforms"
        case shortScreenshots = "short_screenshots"
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
