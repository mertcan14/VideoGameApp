//
//  MockHomeViewController.swift
//  VideoGameAppTests
//
//  Created by mertcan YAMAN on 31.07.2023.
//

import Foundation
@testable import Video_Games

final class MockHomeViewController: HomeViewControllerProtocol {
    var isInvokedSetSliderImages = false
    var invokedSetSliderImagesCount = 0
    var invokedSetVideoGameParameters: (videoGame: [VideoGame], Void)?
    func setSliderImages(_ videoGame: [VideoGame]) {
        isInvokedSetSliderImages = true
        invokedSetSliderImagesCount += 1
        invokedSetVideoGameParameters = (videoGame, ())
    }
    
    var isInvokedCollectionViewRegister = false
    var invokedCollectionViewRegisterCount = 0
    func collectionViewRegister() {
        isInvokedCollectionViewRegister = true
        invokedCollectionViewRegisterCount += 1
    }
    
    var isInvokedReloadData = false
    var invokedReloadDataCount = 0
    func reloadData() {
        isInvokedReloadData = true
        invokedReloadDataCount += 1
    }
    
    var isInvokedHidePageView = false
    var invokedHidePageViewCount = 0
    func hidePageView() {
        isInvokedHidePageView = true
        invokedHidePageViewCount += 1
    }
    
    var isInvokedShowPageView = false
    var invokedShowPageViewCount = 0
    func showPageView() {
        isInvokedShowPageView = true
        invokedShowPageViewCount += 1
    }
    
    var isInvokedSetupCollectionViewLayout = false
    var invokedSetupCollectionViewLayoutCount = 0
    func setupCollectionViewLayout() {
        isInvokedSetupCollectionViewLayout = true
        invokedSetupCollectionViewLayoutCount += 1
    }
    
    var isInvokedSetPageRefreshing = false
    var invokedSetPageRefreshingCount = 0
    func setPageRefreshing() {
        isInvokedSetPageRefreshing = true
        invokedSetPageRefreshingCount += 1
    }
    
    var isInvokedConfigFiltersButton = false
    var invokedConfigFiltersButtonCount = 0
    func configFiltersButton() {
        isInvokedConfigFiltersButton = true
        invokedConfigFiltersButtonCount += 1
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
    
    var isInvokedShowPopUp = false
    var invokedShowPopUpCount = 0
    func showPopUp(_ title: String, _ message: String, buttonTitle: String?, buttonAction: (() -> Void)?, cancelAction: (() -> Void)?) {
        isInvokedShowPopUp = true
        invokedShowPopUpCount += 1
    }
}
