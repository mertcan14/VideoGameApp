//
//  VideoGameListInteractor.swift
//  VideoGameApp
//
//  Created by mertcan YAMAN on 31.07.2023.
//

import VideoGameAPI

protocol VideoGameListBusinessLogic {
    func fetchVideoGameList()
    func fetchNextPage(url: String)
    func fetchWithParams(params: [String: String])
    func setGameId(_ id: String)
}

protocol VideoGameListDataStore {
    var gameID: String { get set }
}

final class VideoGameListInteractor: VideoGameListDataStore {
    var presenter: VideoGameListPresentationLogic?
    var gameID: String = ""
    lazy var request = GetListVideoGameRequest(urlConst: nil)
}

extension VideoGameListInteractor: VideoGameListBusinessLogic {
    func setGameId(_ id: String) {
        gameID = id
    }
    
    func fetchWithParams(params: [String: String]) {
        NetworkService.shared.fetchFromAPI(GetListVideoGameRequest(params: params)) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let games):
                let response = VideoGameList.FetchVideoGameList.Response(videoGameResult: games)
                self.presenter?.presentVideoGameList(response: response)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func fetchNextPage(url: String) {
        NetworkService.shared.fetchFromAPI(GetListVideoGameRequest(urlConst: url)) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let games):
                let response = VideoGameList.FetchNextPage.Response(videoGameResult: games)
                self.presenter?.presentNextPage(response: response)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func fetchVideoGameList() {
        NetworkService.shared.fetchFromAPI(request) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let games):
                let response = VideoGameList.FetchVideoGameList.Response(videoGameResult: games)
                self.presenter?.presentVideoGameList(response: response)
            case .failure(let error):
                print(error)
            }
        }
    }
}
