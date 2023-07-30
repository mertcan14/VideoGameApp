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
// MARK: Class VideoGameTabBarController
final class VideoGameTabBarController: UITabBarController {
    init(tabs: VideoGameTabs) {
        super.init(nibName: nil, bundle: nil)
        
        viewControllers = [tabs.home, tabs.favorites]
        tabBar.barTintColor = .tabBarColor
        tabBar.backgroundColor = .tabBarColor
        tabBar.tintColor = .fieldColor
        tabBar.unselectedItemTintColor = .lightGray
        tabBar.isTranslucent = true
        
        if #available(iOS 15.0, *) {
            let appearance = UITabBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = .tabBarColor
            tabBar.standardAppearance = appearance
            tabBar.scrollEdgeAppearance = UITabBar.appearance().standardAppearance
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
