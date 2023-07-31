//
//  MockHomeInteractor.swift
//  VideoGameAppTests
//
//  Created by mertcan YAMAN on 31.07.2023.
//

import Foundation
@testable import Video_Games

final class MockHomeInteractor: HomeInteractorProtocol {
    var isInvokedfetchGames = false
    var invokedfetchGamesCount = 0
    var invokedSetURLParameter: (url: String?, Void)?
    func fetchGames(_ url: String?) {
        isInvokedfetchGames = true
        invokedfetchGamesCount += 1
        invokedSetURLParameter = (url, ())
    }
    
    var isInvokedFetchGamesWithParams = false
    var invokedFetchGamesWithParamsCount = 0
    var invokedSetParamsParameter: (params: [String: String], Void)?
    func fetchGamesWithParams(_ params: [String: String]) {
        isInvokedFetchGamesWithParams = true
        invokedFetchGamesWithParamsCount += 1
        invokedSetParamsParameter = (params, ())
    }
}
