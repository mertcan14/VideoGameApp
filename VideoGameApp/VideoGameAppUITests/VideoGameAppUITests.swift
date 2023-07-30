//
//  VideoGameAppUITests.swift
//  VideoGameAppUITests
//
//  Created by mertcan YAMAN on 12.07.2023.
//

import XCTest

final class VideoGameAppUITests: XCTestCase {
    func test_homescreen() throws {
        let app = XCUIApplication()
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
        sleep(1)
        app.keyboards.keys["h"].tap()
        sleep(1)
        app.keyboards.keys["e"].tap()
        sleep(1)
        searchTextFieldElement.clearAndEnterText(text: "")
        sleep(1)
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
