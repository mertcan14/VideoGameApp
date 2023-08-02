//
//  VideoGameDetailRouter.swift
//  VideoGameApp
//
//  Created by mertcan YAMAN on 2.08.2023.
//

import Foundation

protocol VideoGameDetailRoutingLogic {}

protocol VideoGameDetailDataPassing {
    var dataStore: VideoGameDetailDataStore? { get }
}

final class VideoGameDetailRouter: NSObject,
                                          VideoGameDetailRoutingLogic,
                                          VideoGameDetailDataPassing {
    weak var viewController: VideoGameDetailViewController?
    var dataStore: VideoGameDetailDataStore?
}
