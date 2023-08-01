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
    private let videoGame: VideoGameNetworkModel
    
    init(view: VideoGameCollectionViewCellProtocol?, videoGame: VideoGameNetworkModel) {
        self.view = view
        self.videoGame = videoGame
    }
}
// MARK: Extension VideoGameCellPresenterProtocol
extension VideoGameCellPresenter: VideoGameCellPresenterProtocol {
    func load() {
        self.view?.setImage(self.videoGame.backgroundImage)
        self.view?.setNameOfGame(self.videoGame.name)
        self.view?.setRatingOfGame(self.videoGame.rating)
        self.view?.setReleasedOfGame(self.videoGame.released)
    }
}
