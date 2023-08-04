//
//  HomePresenterTest.swift
//  VideoGameAppTests
//
//  Created by mertcan YAMAN on 22.07.2023.
//

import XCTest
@testable import Video_Games

final class HomePresenterTest: XCTestCase {
    var presenter: HomePresenter!
    var view: MockHomeViewController!
    var router: MockHomeRouter!
    var interactor: MockHomeInteractor!
    let videoGameCell: VideoGameCellModel = VideoGameCellModel(
        imageURL: "https://media.rawg.io/media/crop/600/400/games/456/456dea5e1c7e3cd07060c14e96612001.jpg",
        nameOfGame: "Grand Theft Auto V",
        ratingOfGame: 4.47,
        releasedOfGame: "2013-09-17")
    
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
        XCTAssertFalse(view.isInvokedCollectionViewRegister)
        XCTAssertEqual(view.invokedCollectionViewRegisterCount, 0)
        XCTAssertFalse(view.isInvokedSetupCollectionViewLayout)
        XCTAssertEqual(view.invokedSetupCollectionViewLayoutCount, 0)
        XCTAssertFalse(view.isInvokedConfigFiltersButton)
        XCTAssertEqual(view.invokedConfigFiltersButtonCount, 0)
        
        presenter.viewDidLoad()
        
        XCTAssertTrue(view.isInvokedCollectionViewRegister)
        XCTAssertEqual(view.invokedCollectionViewRegisterCount, 1)
        XCTAssertTrue(view.isInvokedSetupCollectionViewLayout)
        XCTAssertEqual(view.invokedSetupCollectionViewLayoutCount, 1)
        XCTAssertTrue(view.isInvokedConfigFiltersButton)
        XCTAssertEqual(view.invokedConfigFiltersButtonCount, 1)
    }
    
    func test_viewDidLoad_InvokesRequiredInteractorMethods() {
        XCTAssertFalse(interactor.isInvokedfetchGames)
        XCTAssertEqual(interactor.invokedfetchGamesCount, 0)
        XCTAssertNil(interactor.invokedSetURLParameter)
        
        presenter.viewDidLoad()
        
        XCTAssertTrue(interactor.isInvokedfetchGames)
        XCTAssertEqual(interactor.invokedfetchGamesCount, 1)
        XCTAssertNil(interactor.invokedSetURLParameter?.url)
    }
    
    func test_searchVideoGame_InvokesRequiredViewMethods() {
        XCTAssertFalse(view.isInvokedReloadData)
        XCTAssertEqual(view.invokedReloadDataCount, 0)
        XCTAssertFalse(view.isInvokedHidePageView)
        XCTAssertEqual(view.invokedHidePageViewCount, 0)
        
        presenter.searchVideoGame("Search")
        
        XCTAssertTrue(view.isInvokedReloadData)
        XCTAssertEqual(view.invokedReloadDataCount, 1)
        XCTAssertTrue(view.isInvokedHidePageView)
        XCTAssertEqual(view.invokedHidePageViewCount, 1)
    }
    
    func test_getGames() {
        XCTAssertEqual(presenter.numberOfVideoGames, 0)
        XCTAssertNil(presenter.getVideoGameByIndex(0))
        XCTAssertFalse(view.isInvokedSetSliderImages)
        XCTAssertEqual(view.invokedSetSliderImagesCount, 0)
        XCTAssertFalse(view.isInvokedReloadData)
        XCTAssertEqual(view.invokedReloadDataCount, 0)
        XCTAssertNil(presenter.getVideoGameByIndex(0))
        
        presenter.getGames(.response)
        
        XCTAssertEqual(presenter.numberOfVideoGames, 20)
        XCTAssertNotNil(presenter.getVideoGameByIndex(0))
        XCTAssertTrue(view.isInvokedSetSliderImages)
        XCTAssertEqual(view.invokedSetSliderImagesCount, 1)
        XCTAssertTrue(view.isInvokedReloadData)
        XCTAssertEqual(view.invokedReloadDataCount, 1)
        XCTAssertEqual(presenter.getVideoGameByIndex(0)?.imageURL, videoGameCell.imageURL)
        
        presenter.getGames(.response)
        
        XCTAssertEqual(presenter.numberOfVideoGames, 40)
        XCTAssertNotNil(presenter.getVideoGameByIndex(0))
        XCTAssertTrue(view.isInvokedSetSliderImages)
        XCTAssertEqual(view.invokedSetSliderImagesCount, 2)
        XCTAssertTrue(view.isInvokedReloadData)
        XCTAssertEqual(view.invokedReloadDataCount, 2)
        XCTAssertEqual(presenter.getVideoGameByIndex(0)?.imageURL, videoGameCell.imageURL)
    }
    
    func test_refreshGames() {
        XCTAssertEqual(presenter.numberOfVideoGames, 0)
        XCTAssertNil(presenter.getVideoGameByIndex(0))
        XCTAssertFalse(view.isInvokedSetSliderImages)
        XCTAssertEqual(view.invokedSetSliderImagesCount, 0)
        XCTAssertFalse(view.isInvokedReloadData)
        XCTAssertEqual(view.invokedReloadDataCount, 0)
        XCTAssertNil(presenter.getVideoGameByIndex(0))
        
        presenter.refreshGames(.response)
        
        XCTAssertEqual(presenter.numberOfVideoGames, 20)
        XCTAssertNotNil(presenter.getVideoGameByIndex(0))
        XCTAssertTrue(view.isInvokedSetSliderImages)
        XCTAssertEqual(view.invokedSetSliderImagesCount, 1)
        XCTAssertTrue(view.isInvokedReloadData)
        XCTAssertEqual(view.invokedReloadDataCount, 1)
        XCTAssertEqual(presenter.getVideoGameByIndex(0)?.imageURL, videoGameCell.imageURL)
        
        presenter.refreshGames(.response)
        
        XCTAssertEqual(presenter.numberOfVideoGames, 20)
        XCTAssertNotNil(presenter.getVideoGameByIndex(0))
        XCTAssertTrue(view.isInvokedSetSliderImages)
        XCTAssertEqual(view.invokedSetSliderImagesCount, 2)
        XCTAssertTrue(view.isInvokedReloadData)
        XCTAssertEqual(view.invokedReloadDataCount, 2)
        XCTAssertEqual(presenter.getVideoGameByIndex(0)?.imageURL, videoGameCell.imageURL)
    }
    
    func test_goDetailScreen() {
        XCTAssertFalse(router.isInvokedNavigate)
        XCTAssertEqual(router.invokedNavigateCount, 0)
        XCTAssertNil(router.invokedSetRouteParameters)
        
        presenter.getGames(.response)
        presenter.goDetailScreen(0, false)
        
        XCTAssertTrue(router.isInvokedNavigate)
        XCTAssertEqual(router.invokedNavigateCount, 1)
        XCTAssertNotNil(router.invokedSetRouteParameters?.route)
    }
    
    func atest_searchVideoGame() {
        XCTAssertNil(presenter.getSearchedVideoGameByIndex(0))
        XCTAssertEqual(presenter.numberOfSearchedVideoGames, 0)
        
        presenter.getGames(.response)
        presenter.searchVideoGame("The")
        
        XCTAssertNotNil(presenter.getSearchedVideoGameByIndex(0))
    }
}

extension VideoGameResult {
    // swiftlint:disable force_try
    static var response: VideoGameResult {
        let bundle = Bundle(for: HomePresenterTest.self)
        let path = bundle.path(forResource: "ListVideoGame", ofType: "json")!
        let file = try! String(contentsOfFile: path)
        let data = file.data(using: .utf8)!
        let response = try! JSONDecoder().decode(VideoGameResult.self, from: data)
        return response
    }
    // swiftlint:enable force_try
}
