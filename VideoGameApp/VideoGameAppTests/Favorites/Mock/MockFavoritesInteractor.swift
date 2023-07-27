//
//  MockFavoritesInteractor.swift
//  VideoGameAppTests
//
//  Created by mertcan YAMAN on 24.07.2023.
//

import Foundation
@testable import Video_Games

final class MockFavoritesInteractor: FavoritesInteractorProtocol {
    var isInvokedFetchVideoGames = false
    var invokedFetchVideoGamesCount = 0
    func fetchVideoGames() {
        isInvokedFetchVideoGames = true
        invokedFetchVideoGamesCount += 1
    }
}
