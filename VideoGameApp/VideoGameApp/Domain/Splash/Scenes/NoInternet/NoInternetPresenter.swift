//
//  NoInternetPresenter.swift
//  VideoGameApp
//
//  Created by mertcan YAMAN on 2.08.2023.
//

import Foundation
// MARK: Protocol NoInternetPresenterProtocol
protocol NoInternetPresentationLogic: AnyObject {
    func getIsConnection(response: NoInternetModels.CheckInternetConnection.Response)
}
// MARK: Class NoInternetPresenter
final class NoInternetPresenter {
    weak var viewController: NoInternetDisplayLogic?
}
// MARK: Class NoInternetPresentationLogic
extension NoInternetPresenter: NoInternetPresentationLogic {
    func getIsConnection(response: NoInternetModels.CheckInternetConnection.Response) {
        let viewModel = NoInternetModels.CheckInternetConnection.ViewModel(isConnection: response.isConnection)
        viewController?.getIsConnection(viewModel: viewModel)
    }
}
