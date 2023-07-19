//
//  VideoGameCellPresenter.swift
//  VideoGameApp
//
//  Created by mertcan YAMAN on 17.07.2023.
//

import Foundation
// MARK: Protocol VideoGameCellPresenterProtocol
protocol VideoGameCellPresenterProtocol {
    func load()
}
// MARK: class VideoGameCellPresenter
final class VideoGameCellPresenter {
    weak var view: VideoGameCollectionViewCellProtocol?
    private let videoGame: VideoGameCellModel
    
    init(view: VideoGameCollectionViewCellProtocol?, videoGame: VideoGameCellModel) {
        self.view = view
        self.videoGame = videoGame
    }
}
// MARK: Extension VideoGameCellPresenterProtocol
extension VideoGameCellPresenter: VideoGameCellPresenterProtocol {
    func load() {
        self.view?.setImage(self.videoGame.imageURL)
        self.view?.setNameOfGame(self.videoGame.nameOfGame)
        self.view?.setRatingOfGame(self.videoGame.ratingOfGame)
        self.view?.setReleasedOfGame(self.videoGame.releasedOfGame)
    }
}
