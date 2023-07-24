//
//  MockFavoritesRouter.swift
//  VideoGameAppTests
//
//  Created by mertcan YAMAN on 24.07.2023.
//

import Foundation
@testable import VideoGameApp

final class MockFavoritesRouter: FavoritesRouterProtocol {
    var isInvokedNavigate = false
    var invokedNavigateCount = 0
    var invokedSetRouteParameters: (route: FavoritesRoutes, Void)?
    func navigate(_ route: VideoGameApp.FavoritesRoutes) {
        isInvokedNavigate = true
        invokedNavigateCount += 1
        invokedSetRouteParameters = (route, ())
    }
}
