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
    private var videoGames: [VideoGame] = [] {
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
            self.videoGames.forEach {[weak self] videoGame in
                self?.individualPageViewControllerList.append(
                    PageDetailViewController.getInstance(videoGame: videoGame)
                )
            }
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
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(getvideoGames(notification:)),
                                               name: Notification.Name("GetvideoGames"),
                                               object: nil)
    }
    
    @objc func getvideoGames(notification: Notification) {
        guard let imagesAny = notification.userInfo?["videoGame"],
              let videoGames = imagesAny as? [VideoGame] else { return }
        self.videoGames = videoGames
    }
}

// MARK: - Extension UIPageViewControllerDelegate
extension HomePageViewController: UIPageViewControllerDelegate {
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return self.videoGames.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return 0
    }
}

// MARK: - Extension UIPageViewControllerDataSource
extension HomePageViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let indexOfCurrentPageVC = individualPageViewControllerList
            .firstIndex(of: viewController) else { return nil }
        return indexOfCurrentPageVC == 0 ? nil : self.individualPageViewControllerList[indexOfCurrentPageVC - 1]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let indexOfCurrentPageVC = individualPageViewControllerList
            .firstIndex(of: viewController) else { return nil }
        let lastViewController = individualPageViewControllerList.count - 1
        return indexOfCurrentPageVC == lastViewController ? nil : self.individualPageViewControllerList[indexOfCurrentPageVC + 1]
    }
}
