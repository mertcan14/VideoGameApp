//
//  VideoGameDetailRouter.swift
//  VideoGameApp
//
//  Created by mertcan YAMAN on 2.08.2023.
//

import Foundation
import SafariServices

protocol VideoGameDetailRoutingLogic {
    func routeToWeb(url: URL)
}

protocol VideoGameDetailDataPassing {
    var dataStore: VideoGameDetailDataStore? { get }
}

final class VideoGameDetailRouter: NSObject,
                                          VideoGameDetailRoutingLogic,
                                   VideoGameDetailDataPassing {
    weak var viewController: VideoGameDetailViewController?
    var dataStore: VideoGameDetailDataStore?
    
    func routeToWeb(url: URL) {
        guard let viewController = viewController else { return }
        let vc = SFSafariViewController(url: url, entersReaderIfAvailable: true)
        vc.delegate = viewController as? any SFSafariViewControllerDelegate
        viewController.present(vc, animated: true)
    }
}
