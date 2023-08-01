//
//  VideoGameListRouter.swift
//  VideoGameApp
//
//  Created by mertcan YAMAN on 31.07.2023.
//

import Foundation

protocol VideoGameListRoutingLogic {}

protocol VideoGameListDataPassing {}

final class VideoGameListRouter: NSObject, VideoGameListRoutingLogic, VideoGameListDataPassing {
  weak var viewController: VideoGameListViewController?
  var dataStore: VideoGameListDataStore?
}
