//
//  FavoritesPresenterTests.swift
//  VideoGameAppTests
//
//  Created by mertcan YAMAN on 24.07.2023.
//

import XCTest
@testable import Video_Games

final class FavoritesPresenterTests: XCTestCase {
    var presenter: FavoritesPresenter!
    var view: MockFavoritesViewController!
    var router: MockFavoritesRouter!
    var interactor: MockFavoritesInteractor!
    
    override func setUp() {
        super.setUp()
        view = .init()
        router = .init()
        interactor = .init()
        presenter = .init(view, router, interactor)
    }
    
    override func tearDown() {
        view = nil
        presenter = nil
        router = nil
        interactor = nil
    }
    
    func test_viewDidLoad() {
        XCTAssertFalse(view.isInvokedCollectionViewRegister)
        XCTAssertEqual(view.invokedCollectionViewRegisterCount, 0)
        XCTAssertFalse(view.isInvokedCollectionViewLayout)
        XCTAssertEqual(view.invokedCollectionViewLayoutCount, 0)
        
        presenter.viewDidLoad()
        
        XCTAssertTrue(view.isInvokedCollectionViewRegister)
        XCTAssertEqual(view.invokedCollectionViewRegisterCount, 1)
        XCTAssertTrue(view.isInvokedCollectionViewLayout)
        XCTAssertEqual(view.invokedCollectionViewLayoutCount, 1)
    }
    
    func test_viewWillAppear() {
        XCTAssertFalse(interactor.isInvokedFetchVideoGames)
        XCTAssertEqual(interactor.invokedFetchVideoGamesCount, 0)
        
        presenter.viewWillAppear()
        
        XCTAssertTrue(interactor.isInvokedFetchVideoGames)
        XCTAssertEqual(interactor.invokedFetchVideoGamesCount, 1)
    }
    
    func test_getVideoGame() {
        XCTAssertEqual(presenter.numberOfVideoGame, 0)
        XCTAssertFalse(view.isInvokedReloadData)
        XCTAssertEqual(view.invokedReloadDataCount, 0)
        XCTAssertNil(presenter.getVideoGameByIndex(0))
        
        let videoGames = VideoGameResult.response.results!
        presenter.getVideoGames(videoGames)
        
        XCTAssertEqual(presenter.numberOfVideoGame, 20)
        XCTAssertTrue(view.isInvokedReloadData)
        XCTAssertEqual(view.invokedReloadDataCount, 1)
        XCTAssertNotNil(presenter.getVideoGameByIndex(0))
        XCTAssertEqual(presenter.getVideoGameByIndex(0)!.nameOfGame, "Grand Theft Auto V")
    }
    
    func test_goDetailScreen() {
        XCTAssertFalse(router.isInvokedNavigate)
        XCTAssertEqual(router.invokedNavigateCount, 0)
        XCTAssertNil(router.invokedSetRouteParameters)
        
        let videoGames = VideoGameResult.response.results!
        presenter.getVideoGames(videoGames)
        presenter.goDetailScreen(0)
        
        XCTAssertTrue(router.isInvokedNavigate)
        XCTAssertEqual(router.invokedNavigateCount, 1)
        XCTAssertNotNil(router.invokedSetRouteParameters)
    }
}
