//
//  MockDetailVideoGameViewController.swift
//  VideoGameAppTests
//
//  Created by mertcan YAMAN on 24.07.2023.
//

import Foundation
@testable import Video_Games

final class MockDetailVideoGameViewController: DetailVideoGameViewControllerProtocol {
    var isInvokedSetImageView = false
    var invokedSetImageViewCount = 0
    var invokedSetURLParameters: (url: String?, Void)?
    func setImageView(_ image: String?) {
        isInvokedSetImageView = true
        invokedSetImageViewCount += 1
        invokedSetURLParameters = (image, ())
    }
    
    var isInvokedSetGameName = false
    var invokedSetGameNameCount = 0
    var invokedSetNameParameters: (name: String?, Void)?
    func setGameName(_ name: String?) {
        isInvokedSetGameName = true
        invokedSetGameNameCount += 1
        invokedSetNameParameters = (name, ())
    }
    
    var isInvokedSetReleasedDate = false
    var invokedSetReleasedDateCount = 0
    var invokedSetDateParameters: (date: String?, Void)?
    func setReleasedDate(_ date: String?) {
        isInvokedSetReleasedDate = true
        invokedSetReleasedDateCount += 1
        invokedSetDateParameters = (date, ())
    }
    
    var isInvokedSetMetacriticRate = false
    var invokedSetMetacriticRateCount = 0
    var invokedSetMetaCriticRateParameters: (metaCriticRate: String?, Void)?
    func setMetacriticRate(_ metaCriticRate: String?) {
        isInvokedSetMetacriticRate = true
        invokedSetMetacriticRateCount += 1
        invokedSetMetaCriticRateParameters = (metaCriticRate, ())
    }
    
    var isInvokedSetDescription = false
    var invokedSetDescriptionCount = 0
    var invokedSetDescriptionParameters: (description: String?, Void)?
    func setDescription(_ description: String?) {
        isInvokedSetDescription = true
        invokedSetDescriptionCount += 1
        invokedSetDescriptionParameters = (description, ())
    }
    
    var isInvokedConfigBackButton = false
    var invokedConfigBackButtonCount = 0
    func configBackButton() {
        isInvokedConfigBackButton = true
        invokedConfigBackButtonCount += 1
    }
    
    var isInvokedConfigLikeButton = false
    var invokedConfigLikeButtonCount = 0
    func configLikeButton() {
        isInvokedConfigLikeButton = true
        invokedConfigLikeButtonCount += 1
    }
    
    var isInvokedIsLikedVideoGame = false
    var invokedIsLikedVideoGameCount = 0
    var invokedSetIsLikedParameters: (isLiked: Bool, Void)?
    func isLikedVideoGame(_ isLiked: Bool) {
        isInvokedIsLikedVideoGame = true
        invokedIsLikedVideoGameCount += 1
        invokedSetIsLikedParameters = (isLiked, ())
    }
    
    var isInvokedUnLikedVideoGame = false
    var invokedUnLikedVideoGameCount = 0
    func unLikedVideoGame() {
        isInvokedUnLikedVideoGame = true
        invokedUnLikedVideoGameCount += 1
    }
    
    var isInvokedShowAlert = false
    var invokedShowAlertCount = 0
    var invokedSetTitleParameters: (title: String, Void)?
    var invokedSetMessageParameters: (message: String, Void)?
    var invokedSetActionParameters: (action: (() -> Void)?, Void)?
    func showAlert(_ title: String, _ message: String, _ action: (() -> Void)?) {
        isInvokedShowAlert = true
        invokedShowAlertCount += 1
        invokedSetTitleParameters = (title, ())
        invokedSetMessageParameters = (message, ())
        invokedSetActionParameters = (action, ())
    }
    
    var isInvokedDelay = false
    var invokedDelayCount = 0
    var invokedSetDelayParameters: (delay: Double, Void)?
    var invokedSetClosureParameters: (closure: () -> Void, Void)?
    func delay(_ delay: Double, closure: @escaping () -> Void) {
        isInvokedDelay = true
        invokedDelayCount += 1
        invokedSetDelayParameters = (delay, ())
        invokedSetClosureParameters = (closure, ())
    }
}
