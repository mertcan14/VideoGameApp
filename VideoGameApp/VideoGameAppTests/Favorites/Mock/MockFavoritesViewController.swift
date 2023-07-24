//
//  MockFavoritesViewController.swift
//  VideoGameAppTests
//
//  Created by mertcan YAMAN on 24.07.2023.
//

import Foundation
@testable import VideoGameApp

final class MockFavoritesViewController: FavoritesViewControllerProtocol {
    var isInvokedReloadData = false
    var invokedReloadDataCount = 0
    func reloadData() {
        isInvokedReloadData = true
        invokedReloadDataCount += 1
    }
    
    var isInvokedCollectionViewLayout = false
    var invokedCollectionViewLayoutCount = 0
    func setupCollectionViewLayout() {
        isInvokedCollectionViewLayout = true
        invokedCollectionViewLayoutCount += 1
    }
    
    var isInvokedCollectionViewRegister = false
    var invokedCollectionViewRegisterCount = 0
    func collectionViewRegister() {
        isInvokedCollectionViewRegister = true
        invokedCollectionViewRegisterCount += 1
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
