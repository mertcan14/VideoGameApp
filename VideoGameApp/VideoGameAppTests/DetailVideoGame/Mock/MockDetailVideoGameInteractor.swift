//
//  MockDetailVideoGameInteractor.swift
//  VideoGameAppTests
//
//  Created by mertcan YAMAN on 24.07.2023.
//

import Foundation
@testable import VideoGameApp

final class MockDetailVideoGameInteractor: DetailVideoGameInteractorProtocol {
    var isInvokedFetchDetailVideoGameById = false
    var invokedFetchDetailVideoGameByIdCount = 0
    var invokedSetIdParameters: (id: String, Void)?
    func fetchDetailVideoGameById(_ id: String) {
        isInvokedFetchDetailVideoGameById = true
        invokedFetchDetailVideoGameByIdCount += 1
        invokedSetIdParameters = (id, ())
    }
    
    var isInvokedLikedVideoGame = false
    var invokedLikedVideoGameCount = 0
    var invokedSetAddObjParameters: (addObj: [String: Any], Void)?
    func likedVideoGame(_ addObj: [String: Any]) {
        isInvokedLikedVideoGame = true
        invokedLikedVideoGameCount += 1
        invokedSetAddObjParameters = (addObj, ())
    }
    
    var isInvokedUnLikedVideoGame = false
    var invokedUnLikedVideoGameCount = 0
    var invokedSetRemoveObjParameters: (removeObj: [String: Any], Void)?
    func unLikedVideoGame(_ removeObj: [String: Any]) {
        isInvokedUnLikedVideoGame = true
        invokedUnLikedVideoGameCount += 1
        invokedSetRemoveObjParameters = (removeObj, ())
    }
    
    var isInvokedIsLikedVideoGame = false
    var invokedIsLikedVideoGameCount = 0
    var invokedSetAddObjIsLikedParameters: (addObj: [String: Any], Void)
    func isLikedVideoGame(_ addObj: [String: Any]) {
        isInvokedIsLikedVideoGame = true
        invokedIsLikedVideoGameCount += 1
        invokedSetAddObjIsLikedParameters = (addObj, ())
    }
}
