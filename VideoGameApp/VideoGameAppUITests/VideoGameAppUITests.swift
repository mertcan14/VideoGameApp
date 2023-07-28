//
//  VideoGameAppUITests.swift
//  VideoGameAppUITests
//
//  Created by mertcan YAMAN on 12.07.2023.
//

import XCTest

final class VideoGameAppUITests: XCTestCase {
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testExample() throws {
        let app = XCUIApplication()
        app.launch()
    }
    
    func test_homescreen() throws {
        let app = XCUIApplication()
        app.launch()
        XCUIDevice.shared.orientation = .portrait
        let scrollViewsQuery = app.scrollViews
        let filterImage = app.images["filter"]
        let searchButtonElement = app.buttons["Search"]
        let searchTextFieldElement = app.textFields["SEARCH"]
        let element2 = scrollViewsQuery.otherElements.scrollViews.children(matching: .other).element.children(matching: .other).element
        let element = element2.children(matching: .other).element(boundBy: 1).children(matching: .other).element(boundBy: 2)
        let element3 = app.scrollViews.otherElements.collectionViews.children(matching: .cell)
            .element(boundBy: 2).children(matching: .other).element.children(matching: .other)
            .element.children(matching: .other).element.children(matching: .other)
            .element.children(matching: .other).element
        
        element.swipeLeft()
        element.swipeLeft()
        element.swipeRight()
        element.swipeRight()
        element3.swipeUp()
        
        XCUIDevice.shared.orientation = .landscapeLeft
        element.swipeLeft()
        element.swipeLeft()
        element.swipeUp()
        element3.swipeUp()
        element3.swipeUp()
        element3.swipeUp()
        filterImage.tap()
        searchButtonElement.tap()
                
        XCUIDevice.shared.orientation = .portrait
        searchTextFieldElement.tap()
        app/*@START_MENU_TOKEN@*/.keys["t"]/*[[".keyboards.keys[\"t\"]",".keys[\"t\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.keys["h"]/*[[".keyboards.keys[\"h\"]",".keys[\"h\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.keys["e"]/*[[".keyboards.keys[\"e\"]",".keys[\"e\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.keys["space"]/*[[".keyboards.keys[\"space\"]",".keys[\"space\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.keys["m"].tap()
        app.keys["e"].tap()
        app.keys["r"].tap()
        app.keys["t"].tap()
        let deleteKey = app.keys["delete"]
        deleteKey.tap()
        deleteKey.tap()
        deleteKey.tap()
        deleteKey.tap()
        deleteKey.tap()
        deleteKey.tap()
        deleteKey.tap()
        deleteKey.tap()
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
