//
//  FiltersPresenter.swift
//  VideoGameApp
//
//  Created by mertcan YAMAN on 26.07.2023.
//

import Foundation
// MARK: Protocol FiltersPresenterProtocol
protocol FiltersPresenterProtocol {
    func fetchWithFilters()
    func setSortButtonTag(_ tag: Int)
}
// MARK: Class FiltersPresenter
final class FiltersPresenter {
    unowned var view: FiltersViewControllerProtocol
    let interactor: HomeInteractorProtocol
    private var selectedTag = 0
    init(view: FiltersViewControllerProtocol, interactor: HomeInteractorProtocol) {
        self.view = view
        self.interactor = interactor
    }
    
    private func getByTag() -> String {
        if selectedTag == 1 {
            return OrderEnum.ratingHighToLow.rawValue
        } else if selectedTag == 2 {
            return OrderEnum.ratingLowToHigh.rawValue
        } else if selectedTag == 3 {
            return OrderEnum.releasedNewToOlder.rawValue
        } else if selectedTag == 4 {
            return OrderEnum.releasedOlderToNew.rawValue
        } else if selectedTag == 5 {
            return OrderEnum.metacriticHighToLow.rawValue
        } else {
            return OrderEnum.metacriticLowToHigh.rawValue
        }
    }
    
    private func checkSortBy() -> String? {
        if selectedTag != 0 {
            return getByTag()
        }
        return nil
    }
    
    private func setParams() -> [String: String]? {
        var params: [String: String] = [:]
        if let metacritic = self.view.checkTextFieldsForMetacritic() {
            params["metacritic"] = metacritic
        }
        if let order = checkSortBy() {
            params["ordering"] = order
        }
        if params != [:] {
            return params
        }
        return nil
    }
}
// MARK: Extension FiltersPresenterProtocol
extension FiltersPresenter: FiltersPresenterProtocol {
    func setSortButtonTag(_ tag: Int) {
        selectedTag = tag
    }
    
    func fetchWithFilters() {
        guard let params = setParams() else {
            self.view.closeScreen()
            return
        }
        self.view.showLoading()
        interactor.fetchGamesWithParams(params)
    }
}
