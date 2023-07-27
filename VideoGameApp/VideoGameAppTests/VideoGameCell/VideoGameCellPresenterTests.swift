//
//  VideoGameCellPresenterTests.swift
//  VideoGameAppTests
//
//  Created by mertcan YAMAN on 24.07.2023.
//

import XCTest
@testable import Video_Games

final class VideoGameCellPresenterTests: XCTestCase {
    var presenter: VideoGameCellPresenter!
    var view: MockVideoGameCollectionViewCell!
    var videoGameCell: VideoGameCellModel!
    
    override func setUp() {
        super.setUp()
        view = .init()
        videoGameCell = .init(imageURL: "https://media.rawg.io/media/crop/600/400/games/456/456dea5e1c7e3cd07060c14e96612001.jpg",
            nameOfGame: "Grand Theft Auto V",
            ratingOfGame: 4.47,
            releasedOfGame: "2013-09-17")
        presenter = .init(view: view, videoGame: videoGameCell)
    }
    
    override func tearDown() {
        view = nil
        presenter = nil
        videoGameCell = nil
    }
    
    func test_load() {
        XCTAssertFalse(view.isInvokedSetImage)
        XCTAssertEqual(view.invokedSetImageCount, 0)
        XCTAssertNil(view.invokedSetImageParameters)
        XCTAssertFalse(view.isInvokedSetNameOfGame)
        XCTAssertEqual(view.invokedSetNameOfGameCount, 0)
        XCTAssertNil(view.invokedSetTextParameters)
        XCTAssertFalse(view.isInvokedSetRatingOfGame)
        XCTAssertEqual(view.invokedSetRatingOfGameCount, 0)
        XCTAssertNil(view.invokedSetTextRatingParameters)
        XCTAssertFalse(view.isInvokedSetReleasedOfGame)
        XCTAssertEqual(view.invokedSetReleasedOfGameCount, 0)
        XCTAssertNil(view.invokedSetTextReleasedParameters)
        
        presenter.load()
        
        XCTAssertTrue(view.isInvokedSetImage)
        XCTAssertEqual(view.invokedSetImageCount, 1)
        XCTAssertEqual(view.invokedSetImageParameters?.image,
                       "https://media.rawg.io/media/crop/600/400/games/456/456dea5e1c7e3cd07060c14e96612001.jpg")
        XCTAssertTrue(view.isInvokedSetNameOfGame)
        XCTAssertEqual(view.invokedSetNameOfGameCount, 1)
        XCTAssertEqual(view.invokedSetTextParameters?.text, "Grand Theft Auto V")
        XCTAssertTrue(view.isInvokedSetRatingOfGame)
        XCTAssertEqual(view.invokedSetRatingOfGameCount, 1)
        XCTAssertEqual(view.invokedSetTextRatingParameters?.text, 4.47)
        XCTAssertTrue(view.isInvokedSetReleasedOfGame)
        XCTAssertEqual(view.invokedSetReleasedOfGameCount, 1)
        XCTAssertEqual(view.invokedSetTextReleasedParameters?.text, "2013-09-17")
    }
}
