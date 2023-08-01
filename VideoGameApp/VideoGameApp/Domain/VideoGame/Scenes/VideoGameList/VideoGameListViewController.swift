//
//  VideoGameListViewController.swift
//  VideoGameApp
//
//  Created by mertcan YAMAN on 31.07.2023.
//

import UIKit

protocol VideoGameListDisplayLogic: AnyObject {
    func displayVideoGameList(viewModel: VideoGameList.FetchVideoGameList.ViewModel)
}

final class VideoGameListViewController: BaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
