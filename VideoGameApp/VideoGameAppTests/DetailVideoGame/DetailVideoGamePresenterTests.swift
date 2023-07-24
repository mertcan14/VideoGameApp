//
//  DetailVideoGamePresenterTests.swift
//  VideoGameAppTests
//
//  Created by mertcan YAMAN on 24.07.2023.
//

import XCTest
@testable import VideoGameApp

final class DetailVideoGamePresenterTests: XCTestCase {
    var presenter: DetailVideoGamePresenter!
    var view: MockDetailVideoGameViewController!
    var router: MockDetailVideoGameRouter!
    var interactor: MockDetailVideoGameInteractor!
    
    override func setUp() {
        super.setUp()
        view = .init()
        interactor = .init()
        router = .init()
        presenter = .init(view, router, interactor)
    }
    
    override func tearDown() {
        view = nil
        presenter = nil
        router = nil
        interactor = nil
    }
    
    func test_viewDidLoad_InvokesRequiredViewMethods() {
        XCTAssertFalse(view.isInvokedConfigBackButton)
        XCTAssertEqual(view.invokedConfigBackButtonCount, 0)
        XCTAssertFalse(view.isInvokedConfigLikeButton)
        XCTAssertEqual(view.invokedConfigLikeButtonCount, 0)
        
        presenter.viewDidLoad()
        
        XCTAssertTrue(view.isInvokedConfigBackButton)
        XCTAssertEqual(view.invokedConfigBackButtonCount, 1)
        XCTAssertTrue(view.isInvokedConfigLikeButton)
        XCTAssertEqual(view.invokedConfigLikeButtonCount, 1)
    }
    
    func test_getDetailVideoGame() {
        XCTAssertNil(presenter.videoGame)
        XCTAssertFalse(view.isInvokedSetDescription)
        XCTAssertEqual(view.invokedSetDescriptionCount, 0)
        XCTAssertNil(view.invokedSetDescriptionParameters)
        XCTAssertFalse(view.isInvokedSetMetacriticRate)
        XCTAssertEqual(view.invokedSetMetacriticRateCount, 0)
        XCTAssertNil(view.invokedSetMetaCriticRateParameters)
        XCTAssertFalse(view.isInvokedSetGameName)
        XCTAssertEqual(view.invokedSetGameNameCount, 0)
        XCTAssertNil(view.invokedSetNameParameters)
        XCTAssertFalse(view.isInvokedSetReleasedDate)
        XCTAssertEqual(view.invokedSetReleasedDateCount, 0)
        XCTAssertNil(view.invokedSetDateParameters)
        
        presenter.getDetailVideoGame(.detailResponse)
        
        XCTAssertNotNil(presenter.videoGame)
        XCTAssertTrue(view.isInvokedSetDescription)
        XCTAssertEqual(view.invokedSetDescriptionCount, 1)
        XCTAssertNotNil(view.invokedSetDescriptionParameters)
        XCTAssertTrue(view.isInvokedSetMetacriticRate)
        XCTAssertEqual(view.invokedSetMetacriticRateCount, 1)
        XCTAssertNotNil(view.invokedSetMetaCriticRateParameters?.metaCriticRate, "92")
        XCTAssertTrue(view.isInvokedSetGameName)
        XCTAssertEqual(view.invokedSetGameNameCount, 1)
        XCTAssertEqual(view.invokedSetNameParameters?.name, "The Witcher 3: Wild Hunt")
        XCTAssertTrue(view.isInvokedSetReleasedDate)
        XCTAssertEqual(view.invokedSetReleasedDateCount, 1)
        XCTAssertNotNil(view.invokedSetDateParameters?.date, "2015-05-18")
    }
    
    func test_getError() {
        XCTAssertFalse(view.isInvokedShowAlert)
        XCTAssertEqual(view.invokedShowAlertCount, 0)
        
        presenter.getError("errorText")
        
        XCTAssertTrue(view.isInvokedShowAlert)
        XCTAssertEqual(view.invokedShowAlertCount, 1)
    }
    
    func test_likeVideoGame() {
        if presenter.isLiked == false {
            XCTAssertFalse(interactor.isInvokedLikedVideoGame)
            XCTAssertEqual(interactor.invokedLikedVideoGameCount, 0)
        } else {
            XCTAssertFalse(interactor.isInvokedUnLikedVideoGame)
            XCTAssertEqual(interactor.invokedUnLikedVideoGameCount, 0)
        }
        
        presenter.getDetailVideoGame(.detailResponse)
        presenter.likeVideoGame()
        
        if presenter.isLiked == false {
            XCTAssertTrue(interactor.isInvokedLikedVideoGame)
            XCTAssertEqual(interactor.invokedLikedVideoGameCount, 1)
        } else {
            XCTAssertTrue(interactor.isInvokedUnLikedVideoGame)
            XCTAssertEqual(interactor.invokedUnLikedVideoGameCount, 1)
        }
    }
    
    func test_getIsLikedVideoGame() {
        XCTAssertFalse(presenter.isLiked)
        XCTAssertFalse(view.isInvokedIsLikedVideoGame)
        XCTAssertEqual(view.invokedIsLikedVideoGameCount, 0)
        
        presenter.getIsLikedVideoGame(true)
        
        XCTAssertTrue(presenter.isLiked)
        XCTAssertTrue(view.isInvokedIsLikedVideoGame)
        XCTAssertEqual(view.invokedIsLikedVideoGameCount, 1)
    }
    
    func test_getRemoveFromAddObj() {
        presenter.isLiked = true
        
        XCTAssertTrue(presenter.isLiked)
        XCTAssertFalse(view.isInvokedUnLikedVideoGame)
        XCTAssertEqual(view.invokedUnLikedVideoGameCount, 0)
        
        presenter.getRemoveFromAddObj(true)
        
        XCTAssertFalse(presenter.isLiked)
        XCTAssertTrue(view.isInvokedUnLikedVideoGame)
        XCTAssertEqual(view.invokedUnLikedVideoGameCount, 1)
    }
    
    func test_goBackScreen() {
        XCTAssertFalse(router.isInvokedNavigate)
        XCTAssertEqual(router.invokedNavigateCount, 0)
        XCTAssertNil(router.invokedSetRoute)
        
        presenter.goBackScreen()
        
        XCTAssertTrue(router.isInvokedNavigate)
        XCTAssertEqual(router.invokedNavigateCount, 1)
        XCTAssertNotNil(router.invokedSetRoute)
    }
}

extension DetailVideoGame {
    // swiftlint:disable force_try
    static var detailResponse: DetailVideoGame {
        let bundle = Bundle(for: DetailVideoGamePresenterTests.self)
        let path = bundle.path(forResource: "DetailVideoGame", ofType: "json")!
        let file = try! String(contentsOfFile: path)
        let data = file.data(using: .utf8)!
        let response = try! JSONDecoder().decode(DetailVideoGame.self, from: data)
        return response
    }
    // swiftlint:enable force_try
}
