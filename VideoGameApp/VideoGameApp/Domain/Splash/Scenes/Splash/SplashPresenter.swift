//
//  SplashPresenter.swift
//  VideoGameApp
//
//  Created by mertcan YAMAN on 14.07.2023.
//

import Foundation
// MARK: Protocol SplashPresenterProtocol
protocol SplashPresentationLogic: AnyObject {
    func getIsConnection(response: SplashModels.CheckInternetConnection.Response)
}
// MARK: Class SplashPresenter
final class SplashPresenter {
    weak var viewController: SplashDisplayLogic?
}
// MARK: Class SplashPresentationLogic
extension SplashPresenter: SplashPresentationLogic {
    func getIsConnection(response: SplashModels.CheckInternetConnection.Response) {
        let viewModel = SplashModels.CheckInternetConnection.ViewModel(isConnection: response.isConnection)
        viewController?.getIsConnection(viewModel: viewModel)
    }
}
