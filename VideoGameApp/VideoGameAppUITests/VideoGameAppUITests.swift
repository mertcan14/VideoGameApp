//
//  VideoGameAppUITests.swift
//  VideoGameAppUITests
//
//  Created by mertcan YAMAN on 12.07.2023.
//

import XCTest

final class VideoGameAppUITests: XCTestCase {
    
    private var app: XCUIApplication!
    
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        app = XCUIApplication()
    }
    
    func test_homescreen() throws {
        app.launch()
        XCUIDevice.shared.orientation = .portrait
        let scrollViewsQuery = app.scrollViews
        let filterImage = app.images["filter"]
        let searchButtonElement = app.buttons["Search"]
        let searchTextFieldElement = app.textFields["SEARCH"]
        let slider = scrollViewsQuery.otherElements.scrollViews.children(matching: .other).element.children(matching: .other).element
        let collectionCell = app.scrollViews.otherElements.collectionViews.children(matching: .cell)
            .element(boundBy: 2).children(matching: .other).element.children(matching: .other)
            .element.children(matching: .other).element.children(matching: .other)
            .element.children(matching: .other).element
        
        slider.swipeLeft()
        slider.swipeLeft()
        slider.swipeRight()
        slider.swipeRight()
        collectionCell.swipeUp()
        
        XCUIDevice.shared.orientation = .landscapeLeft
        slider.swipeLeft()
        slider.swipeLeft()
        slider.swipeUp()
        collectionCell.swipeUp()
        collectionCell.swipeUp()
        collectionCell.swipeUp()
        filterImage.tap()
        searchButtonElement.tap()
        
        XCUIDevice.shared.orientation = .portrait
        searchTextFieldElement.tap()
        app.keyboards.keys["t"].tap()
        app.keyboards.keys["h"].tap()
        app.keyboards.keys["e"].tap()
        searchTextFieldElement.clearAndEnterText(text: "")
    }
    
    func test_favoritesscreen() {
        app.launch()
        XCUIDevice.shared.orientation = .portrait
        let favoritesTabItem = app.tabBars["Tab Bar"].buttons["Favorites"]
        let collectionView = app.collectionViews.children(matching: .cell).element(boundBy: 2)
        favoritesTabItem.tap()
        if collectionView.exists {
            XCUIDevice.shared.orientation = .landscapeLeft
            XCUIDevice.shared.orientation = .portrait
        } else {
            XCUIDevice.shared.orientation = .landscapeLeft
            collectionView.swipeUp()
            XCUIDevice.shared.orientation = .portrait
            collectionView.swipeDown()
        }
    }
    
    func test_detailscreen() throws {
        app.launch()
        let scrollViewsQuery = app.scrollViews
        let alert = app.alerts["Are you sure?"]
        let scrollViewsQueryDetail = XCUIApplication().scrollViews
        let element = scrollViewsQuery.children(matching: .other)
            .element.children(matching: .other).element(boundBy: 1).children(matching: .other).element
        let image = scrollViewsQuery.children(matching: .other).element.children(matching: .other)
            .element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .image).element(boundBy: 2)
        let slider = scrollViewsQuery.otherElements.scrollViews.children(matching: .other).element.children(matching: .other).element
        
        XCUIDevice.shared.orientation = .portrait
        slider.tap()
        
        element.swipeUp()
        element.swipeUp()
        element.swipeDown()
        element.swipeDown()
        image.tap()
        if alert.exists {
            alert.scrollViews.otherElements.buttons["Remove"].tap()
        }
        image.tap()
        if alert.exists {
            alert.scrollViews.otherElements.buttons["Cancel"].tap()
        }
        
        XCUIDevice.shared.orientation = .landscapeLeft
        element.swipeUp()
        app.scrollViews.otherElements/*@START_MENU_TOKEN@*/.images["globe"]/*[[".images[\"Globe\"]",".images[\"globe\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.buttons["Done"].tap()
    }
    
    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
