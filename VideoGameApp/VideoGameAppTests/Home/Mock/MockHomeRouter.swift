//
//  MockHomeRouter.swift
//  VideoGameAppTests
//
//  Created by mertcan YAMAN on 31.07.2023.
//

import Foundation
@testable import Video_Games

final class MockHomeRouter: HomeRouterProtocol {
    var isInvokedNavigate = false
    var invokedNavigateCount = 0
    var invokedSetRouteParameters: (route: HomeRoutes, Void)?
    func navigate(_ route: HomeRoutes) {
        isInvokedNavigate = true
        invokedNavigateCount += 1
        invokedSetRouteParameters = (route, ())
    }
}
