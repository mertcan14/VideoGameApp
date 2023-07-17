//
//  HomeViewController.swift
//  VideoGameApp
//
//  Created by mertcan YAMAN on 14.07.2023.
//

import UIKit

protocol HomeViewControllerProtocol: AnyObject, BaseViewControllerProtocol {
    func setSliderImages(_ images: [String])
}

final class HomeViewController: BaseViewController {

    @IBOutlet weak var searchView: UIView!
    var presenter: HomePresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.searchView.addBottomBorderWithColor(color: .fieldColor, width: 2)
    }
}

extension HomeViewController: HomeViewControllerProtocol {
    func setSliderImages(_ images: [String]) {
        NotificationCenter.default.post(name: Notification.Name("GetImages"), object: nil, userInfo: ["images": images])
    }
}
