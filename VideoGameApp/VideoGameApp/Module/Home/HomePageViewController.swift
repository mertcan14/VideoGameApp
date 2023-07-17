//
//  HomePageViewController.swift
//  VideoGameApp
//
//  Created by mertcan YAMAN on 16.07.2023.
//

import UIKit

final class HomePageViewController: UIPageViewController {

    var individualPageViewControllerList = [UIViewController]()
    var images: [String] = [] {
        didSet {
            configureViewControllers()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNotificationCenter()
        
        self.view.backgroundColor = .clear
        self.dataSource = self
        self.delegate = self
        
        let pageControl: UIPageControl = UIPageControl.appearance(whenContainedInInstancesOf: [HomePageViewController.self])
        pageControl.pageIndicatorTintColor = UIColor.gray
        pageControl.currentPageIndicatorTintColor = .fieldColor
    }
    
    private func configureViewControllers() {
        DispatchQueue.main.async {
            self.individualPageViewControllerList = [
                PageDetailViewController.getInstance(index: 0, image: self.images[safe: 0]),
                PageDetailViewController.getInstance(index: 1, image: self.images[safe: 1]),
                PageDetailViewController.getInstance(index: 2, image: self.images[safe: 2])
            ]
            self.setViewControllers([self.individualPageViewControllerList[0]], direction: .forward, animated: true)
        }
    }
    
    private func setNotificationCenter() {
        NotificationCenter.default.addObserver(self, selector: #selector(getImages(notification:)), name: Notification.Name("GetImages"), object: nil)
    }
    
    @objc func getImages(notification: Notification) {
        guard let imagesAny = notification.userInfo?["images"],
              let imagesString = imagesAny as? [String] else { return }
        self.images = imagesString
    }
}

extension HomePageViewController: UIPageViewControllerDelegate {
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return 3
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return 0
    }
}

extension HomePageViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let indexOfCurrentPageViewController = individualPageViewControllerList.firstIndex(of: viewController) else { return nil }
        
        if indexOfCurrentPageViewController == 0 {
            return nil
        } else {
            return self.individualPageViewControllerList[indexOfCurrentPageViewController - 1]
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let indexOfCurrentPageViewController = individualPageViewControllerList.firstIndex(of: viewController) else { return nil }
        
        if indexOfCurrentPageViewController == individualPageViewControllerList.count - 1 {
            return nil
        } else {
            return self.individualPageViewControllerList[indexOfCurrentPageViewController + 1]
        }
    }
}
