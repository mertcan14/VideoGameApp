//
//  TabBarRouter.swift
//  VideoGameApp
//
//  Created by mertcan YAMAN on 20.07.2023.
//

import UIKit

protocol TabBarRouterProtocol: AnyObject {
    static func tabs(usingSubModules subModules: VideoGameTabs) -> VideoGameTabs
}

final class TabBarRouter {
    var viewController: UIViewController
    
    init(viewController: UIViewController) {
        self.viewController = viewController
    }
    
    static func createModule(usingSubModules subModules: VideoGameTabs) -> UITabBarController {
        let tabs = TabBarRouter.tabs(usingSubModules: subModules)
        let tabBarController = VideoGameTabBarController(tabs: tabs)
        return tabBarController
    }
}

extension TabBarRouter: TabBarRouterProtocol {
    static func tabs(usingSubModules subModules: VideoGameTabs) -> VideoGameTabs {
        let homeTabBarItem = UITabBarItem(title: "Home", image: .homeicon, tag: 11)
        let playListTabBarItem = UITabBarItem(title: "Favorites", image: .star, tag: 11)
        
        subModules.home.tabBarItem = homeTabBarItem
        subModules.favorites.tabBarItem = playListTabBarItem
        
        return (
            home: subModules.home,
            favorites: subModules.favorites
        )
    }
}
