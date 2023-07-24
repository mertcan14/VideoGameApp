//
//  MockVideoGameCollectionViewCell.swift
//  VideoGameAppTests
//
//  Created by mertcan YAMAN on 24.07.2023.
//

import Foundation
@testable import VideoGameApp

final class MockVideoGameCollectionViewCell: VideoGameCollectionViewCellProtocol {
    var isInvokedSetImage = false
    var invokedSetImageCount = 0
    var invokedSetImageParameters: (image: URL?, Void)?
    func setImage(_ image: URL?) {
        isInvokedSetImage = true
        invokedSetImageCount += 1
        invokedSetImageParameters = (image, ())
    }
    
    var isInvokedSetNameOfGame = false
    var invokedSetNameOfGameCount = 0
    var invokedSetTextParameters: (text: String?, ())?
    func setNameOfGame(_ text: String?) {
        isInvokedSetNameOfGame = true
        invokedSetNameOfGameCount += 1
        invokedSetTextParameters = (text, ())
    }
    
    var isInvokedSetRatingOfGame = false
    var invokedSetRatingOfGameCount = 0
    var invokedSetTextRatingParameters: (text: Double?, ())?
    func setRatingOfGame(_ text: Double?) {
        isInvokedSetRatingOfGame = true
        invokedSetRatingOfGameCount += 1
        invokedSetTextRatingParameters = (text, ())
    }
    
    var isInvokedSetReleasedOfGame = false
    var invokedSetReleasedOfGameCount = 0
    var invokedSetTextReleasedParameters: (text: String?, Void)?
    func setReleasedOfGame(_ text: String?) {
        isInvokedSetReleasedOfGame = true
        invokedSetReleasedOfGameCount += 1
        invokedSetTextReleasedParameters = (text, ())
    }
}
