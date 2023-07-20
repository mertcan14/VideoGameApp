//
//  VideoGameTabBarController.swift
//  VideoGameApp
//
//  Created by mertcan YAMAN on 20.07.2023.
//

import UIKit

typealias VideoGameTabs = (
    home: UIViewController,
    favorites: UIViewController
)

final class VideoGameTabBarController: UITabBarController, LoadingShowable {
    init(tabs: VideoGameTabs) {
        super.init(nibName: nil, bundle: nil)
        
        viewControllers = [tabs.home, tabs.favorites]
        tabBar.backgroundColor = .tabBarColor
        tabBar.unselectedItemTintColor = .white
        tabBar.tintColor = .fieldColor
        tabBar.unselectedItemTintColor = .lightGray
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showLoading()
    }
}
