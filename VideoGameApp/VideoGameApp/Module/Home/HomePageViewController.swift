//
//  HomePageViewController.swift
//  VideoGameApp
//
//  Created by mertcan YAMAN on 16.07.2023.
//

import UIKit

final class HomePageViewController: UIPageViewController {
    // MARK: - Variable Definitions
    private var individualPageViewControllerList = [UIViewController]()
    private var images: [String] = [] {
        didSet {
            configureViewControllers()
        }
    }
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setNotificationCenter()
        setOutlets()
        setUIPageControl()
    }
    
    // MARK: - Funcs For Configure
    private func configureViewControllers() {
        DispatchQueue.main.async {
            self.individualPageViewControllerList = [
                PageDetailViewController.getInstance(index: 0, image: self.images[safe: 0]),
                PageDetailViewController.getInstance(index: 1, image: self.images[safe: 1]),
                PageDetailViewController.getInstance(index: 2, image: self.images[safe: 2])
            ]
            guard let constantindividualPageViewController = self.individualPageViewControllerList[safe: 0] else { return }
            self.setViewControllers([constantindividualPageViewController], direction: .forward, animated: true)
        }
    }
    
    private func setOutlets() {
        self.dataSource = self
        self.delegate = self
    }
    
    private func setUIPageControl() {
        let pageControl: UIPageControl = UIPageControl.appearance(whenContainedInInstancesOf: [HomePageViewController.self])
        pageControl.pageIndicatorTintColor = UIColor.gray
        pageControl.currentPageIndicatorTintColor = .fieldColor
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

// MARK: - Extension UIPageViewControllerDelegate
extension HomePageViewController: UIPageViewControllerDelegate {
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return 3
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return 0
    }
}

// MARK: - Extension UIPageViewControllerDataSource
extension HomePageViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let indexOfCurrentPageVC = individualPageViewControllerList.firstIndex(of: viewController) else { return nil }
        
        return indexOfCurrentPageVC == 0 ? nil : self.individualPageViewControllerList[indexOfCurrentPageVC - 1]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let indexOfCurrentPageVC = individualPageViewControllerList.firstIndex(of: viewController) else { return nil }
        
        let lastViewController = individualPageViewControllerList.count - 1
        return indexOfCurrentPageVC == lastViewController ? nil : self.individualPageViewControllerList[indexOfCurrentPageVC + 1]
    }
}
