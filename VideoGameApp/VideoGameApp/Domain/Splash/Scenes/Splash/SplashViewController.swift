//
//  SplashViewController.swift
//  VideoGameApp
//
//  Created by mertcan YAMAN on 02.08.2023.
//

import UIKit
protocol SplashDisplayLogic: AnyObject {
    func getIsConnection(viewModel: SplashModels.CheckInternetConnection.ViewModel)
}
// MARK: Class SplashViewController
final class SplashViewController: BaseViewController {
    internal var interactor: SplashBusinessLogic?
    internal var router: (NSObjectProtocol &
                          SplashRoutingLogic &
                          SplashDataPassing)?
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
      super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
      setup()
    }

    required init?(coder aDecoder: NSCoder) {
      super.init(coder: aDecoder)
      setup()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        interactor?.checkInternetConnection()
    }
}

extension SplashViewController: SplashDisplayLogic {
    func getIsConnection(viewModel: SplashModels.CheckInternetConnection.ViewModel) {
        if viewModel.isConnection {
            router?.routeToHome()
        } else {
            router?.routeToNoInternet()
        }
    }
}
