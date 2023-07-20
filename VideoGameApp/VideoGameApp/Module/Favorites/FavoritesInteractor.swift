//
//  FavoritesInteractor.swift
//  VideoGameApp
//
//  Created by mertcan YAMAN on 20.07.2023.
//

import Foundation

protocol FavoritesInteractorProtocol: AnyObject {
    
}

protocol FavoritesInteractorOutputProtocol: AnyObject {
    
}

final class FavoritesInteractor {
    var output: FavoritesInteractorOutputProtocol?
}

extension FavoritesInteractor: FavoritesInteractorProtocol {
    
}
