//
//  FavoritesVideoGameListPresenter.swift
//  VideoGameApp
//
//  Created by mertcan YAMAN on 2.08.2023.
//

import Foundation

protocol FavoritesVideoGameListPresentationLogic {
    func presentFavoritesVideoGameList(
        response: FavoritesVideoGameList.FetchVideoGameListFromCoreData.Response)
}

final class FavoritesVideoGameListPresenter {
    weak var viewController: FavoritesVideoGameListDisplayLogic?
    
    private func setImagesForNextPage(
        response: inout FavoritesVideoGameList.FetchVideoGameListFromCoreData.Response
    ) -> FavoritesVideoGameList.FetchVideoGameListFromCoreData.Response {
        guard let count = response.videoGameResult?.count else {return response}
        for index in 0..<count {
            guard let game = response.videoGameResult?[safe: index] else { break }
            response.videoGameResult?[index].backgroundImage = game.backgroundImage?.setParseImageURL()
        }
        return response
    }
}

extension FavoritesVideoGameListPresenter: FavoritesVideoGameListPresentationLogic {
    func presentFavoritesVideoGameList(response: FavoritesVideoGameList.FetchVideoGameListFromCoreData.Response) {
        var changeResponse = response
        let updatedRespone = setImagesForNextPage(response: &changeResponse)
        let viewModel = FavoritesVideoGameList.FetchVideoGameListFromCoreData.ViewModel(
            results: updatedRespone.videoGameResult
        )
        viewController?.displayVideoGameList(viewModel: viewModel)
    }
}
