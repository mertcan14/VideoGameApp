//
//  VideoGameListPresenter.swift
//  VideoGameApp
//
//  Created by mertcan YAMAN on 31.07.2023.
//

import Foundation

protocol VideoGameListPresentationLogic {
    func presentVideoGameList(response: VideoGameList.FetchVideoGameList.Response)
}

final class VideoGameListPresenter {
    weak var viewController: VideoGameListDisplayLogic?
    
    private func setImages(response: inout VideoGameList.FetchVideoGameList.Response)
    -> VideoGameList.FetchVideoGameList.Response {
        guard let count = response.videoGameResult.count else {return response}
        for index in 0..<count {
            guard var game = response.videoGameResult.results?[safe: index] else { break }
            response.videoGameResult.results?[index].backgroundImage = game.backgroundImage?.setParseImageURL()
        }
        return response
    }
}

extension VideoGameListPresenter: VideoGameListPresentationLogic {
    func presentVideoGameList(response: VideoGameList.FetchVideoGameList.Response) {
        var changeResponse = response
        let deneme = setImages(response: &changeResponse)
        let viewModel = VideoGameList.FetchVideoGameList.ViewModel(
            next: deneme.videoGameResult.next,
            results: deneme.videoGameResult.results)
        viewController?.displayVideoGameList(viewModel: viewModel)
    }
}
