//
//  FavoritesViewController.swift
//  VideoGameApp
//
//  Created by mertcan YAMAN on 20.07.2023.
//

import UIKit

protocol FavoritesViewControllerProtocol: BaseViewControllerProtocol {
    
}

final class FavoritesViewController: BaseViewController {
    var presenter: FavoritesPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension FavoritesViewController: FavoritesViewControllerProtocol {
    
}
