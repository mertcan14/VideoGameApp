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
    func getSavedVideoGame(
        response: VideoGameDetailModels.SaveVideoGame.Response)
    func getIsDeletedVideoGame(
        response: VideoGameDetailModels.DeleteSavedVideoGame.Response)
}

final class VideoGameDetailPresenter {
    weak var viewController: VideoGameDetailDisplayLogic?
}

extension VideoGameDetailPresenter: VideoGameDetailPresentationLogic {
    func getSavedVideoGame(response: VideoGameDetailModels.SaveVideoGame.Response) {
        let viewModel = VideoGameDetailModels.SaveVideoGame.ViewModel(isLike: response.isLike)
        viewController?.displayIsLikedVideoGame(isLike: viewModel.isLike)
    }
    
    func getIsDeletedVideoGame(response: VideoGameDetailModels.DeleteSavedVideoGame.Response) {
        let viewModel = VideoGameDetailModels.FetchIsLikedVideoGame.ViewModel(isLike: response.isDelete)
        viewController?.displayIsLikedVideoGame(isLike: !viewModel.isLike)
    }
    
    func getIsLikedVideoGame(response: VideoGameDetailModels.FetchIsLikedVideoGame.Response) {
        let viewModel = VideoGameDetailModels.FetchIsLikedVideoGame.ViewModel(isLike: response.isLike)
        viewController?.displayIsLikedVideoGame(isLike: viewModel.isLike)
    }
    
    func presentVideoGameDetail(response: VideoGameDetailModels.FetchVideoGameDetail.Response) {
        let viewModel = VideoGameDetailModels.FetchVideoGameDetail.ViewModel(
            results: response.videoGameResult
        )
        viewController?.displayVideoGameList(viewModel: viewModel)
    }
}
