//
//  DetailVideoGameModel.swift
//  VideoGameApp
//
//  Created by mertcan YAMAN on 13.07.2023.
//

import Foundation

// MARK: - DetailVideoGameResult
struct DetailVideoGameResult: Decodable {
    let id: Int?
    let slug, name, description: String?
    let metacritic: Int?
    let released: String?
    let backgroundImage, backgroundImageAdditional: String?
    let website: String?
    let rating: Double?
    let ratingTop: Int?
    let ratings: [Rating]?
    let added: Int?
    let addedByStatus: AddedByStatus?
    let playtime: Int?
    let achievementsCount, parentAchievementsCount: Int?
    let ratingsCount, suggestionsCount: Int?
    let reviewsCount: Int?
    let saturatedColor, dominantColor: String?
    let parentPlatforms: [ParentPlatform]?
    let developers, genres, tags, publishers: [Developer]?

    enum CodingKeys: String, CodingKey {
        case id, slug, name
        case description, metacritic
        case released
        case backgroundImage = "background_image"
        case backgroundImageAdditional = "background_image_additional"
        case website, rating
        case ratingTop = "rating_top"
        case ratings, added
        case addedByStatus = "added_by_status"
        case playtime
        case achievementsCount = "achievements_count"
        case parentAchievementsCount = "parent_achievements_count"
        case ratingsCount = "ratings_count"
        case suggestionsCount = "suggestions_count"
        case reviewsCount = "reviews_count"
        case saturatedColor = "saturated_color"
        case dominantColor = "dominant_color"
        case parentPlatforms = "parent_platforms"
        case developers, genres, tags, publishers
    }
}

// MARK: - AddedByStatus
struct AddedByStatus: Decodable {
    let yet, owned, beaten, toplay: Int?
    let dropped, playing: Int?
}

// MARK: - Developer
struct Developer: Decodable {
    let id: Int?
    let name, slug: String?
    let gamesCount: Int?
    let imageBackground: String?
    let domain: String?

    enum CodingKeys: String, CodingKey {
        case id, name, slug
        case gamesCount = "games_count"
        case imageBackground = "image_background"
        case domain
    }
}

// MARK: - Rating
struct Rating: Decodable {
    let id: Int?
    let title: String?
    let count: Int?
    let percent: Double?
}
