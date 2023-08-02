//
//  VideoGameDetailPresenter.swift
//  VideoGameApp
//
//  Created by mertcan YAMAN on 2.08.2023.
//

import Foundation

protocol VideoGameDetailPresentationLogic {
    func presentVideoGameDetail(
        response: VideoGameDetailModels.FetchVideoGameDetail.Response)
    func getIsLikedVideoGame(
        response: VideoGameDetailModels.FetchIsLikedVideoGame.Response)
}

final class VideoGameDetailPresenter {
    weak var viewController: VideoGameDetailDisplayLogic?
}

extension VideoGameDetailPresenter: VideoGameDetailPresentationLogic {
    func getIsLikedVideoGame(response: VideoGameDetailModels.FetchIsLikedVideoGame.Response) {
        let viewModel = VideoGameDetailModels.FetchIsLikedVideoGame.ViewModel(isLike: response.isLike)
        viewController?.displayIsLikedVideoGame(viewModel: viewModel)
    }
    
    func presentVideoGameDetail(response: VideoGameDetailModels.FetchVideoGameDetail.Response) {
        let viewModel = VideoGameDetailModels.FetchVideoGameDetail.ViewModel(
            results: response.videoGameResult
        )
        viewController?.displayVideoGameList(viewModel: viewModel)
    }
}
