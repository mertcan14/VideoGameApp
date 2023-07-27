//
//  MockDetailVideoGameRouter.swift
//  VideoGameAppTests
//
//  Created by mertcan YAMAN on 24.07.2023.
//

import Foundation
@testable import Video_Games

final class MockDetailVideoGameRouter: DetailVideoGameRouterProtocol {
    var isInvokedNavigate = false
    var invokedNavigateCount = 0
    var invokedSetRoute: (route: DetailVideoGameRoutes, Void)?
    func navigate(_ route: DetailVideoGameRoutes) {
        isInvokedNavigate = true
        invokedNavigateCount += 1
        invokedSetRoute = (route, ())
    }
}
