//
//  ViewController.swift
//  VideoGameApp
//
//  Created by mertcan YAMAN on 12.07.2023.
//

import UIKit
import VideoGameAPI

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getDetailVideoGame("3328")
    }
    
    func getListVideoGame() {
        NetworkService.shared.getListVideoGame { [weak self] response in
            switch response {
            case .success(let videoGameResult):
                print(videoGameResult)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func getDetailVideoGame(_ idOfGame: String) {
        NetworkService.shared.getDetailVideoGame(idOfGame: idOfGame) { [weak self] response in
            switch response {
            case .success(let videoGameResult):
                print(videoGameResult)
            case .failure(let error):
                print(error)
            }
        }
    }
}
