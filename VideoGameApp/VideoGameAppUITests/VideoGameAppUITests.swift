//
//  VideoGameAppUITests.swift
//  VideoGameAppUITests
//
//  Created by mertcan YAMAN on 12.07.2023.
//

import XCTest

final class VideoGameAppUITests: XCTestCase {
<<<<<<< HEAD

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
=======
    private var app: XCUIApplication!
    
    override func setUp() {
        super.setUp()
>>>>>>> ui-test
        continueAfterFailure = false
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        let app = XCUIApplication()
        app.launch()
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
