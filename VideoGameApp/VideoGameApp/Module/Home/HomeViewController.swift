//
//  HomeViewController.swift
//  VideoGameApp
//
//  Created by mertcan YAMAN on 14.07.2023.
//

import UIKit
// MARK: Protocol BaseViewControllerProtocol
protocol HomeViewControllerProtocol: BaseViewControllerProtocol {
    func setSliderImages(_ images: [String])
    func collectionViewRegister()
    func reloadData()
}

final class HomeViewController: BaseViewController {
    // MARK: - IBOutlet Definitions
    @IBOutlet weak var gameCollectionView: UICollectionView!
    @IBOutlet weak var searchView: UIView!
    
    // MARK: - Variable Definitions
    public var presenter: HomePresenterProtocol!
    private var collectionViewFlowLayout: UICollectionViewFlowLayout!
    private var numberOfItemPerRow: CGFloat = 1
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        setupCollectionViewLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        checkDeviceOrientation()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.searchView.addBottomBorderWithColor(color: .fieldColor, width: 2)
    }
    
    override func viewDidLayoutSubviews() {
        updateCollectionViewItemSize()
    }
    
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        if UIApplication.shared.statusBarOrientation.isLandscape {
            self.numberOfItemPerRow = 2
        } else {
            self.numberOfItemPerRow = 1
        }
    }
    
    // MARK: - Funcs For Configure
    private func checkDeviceOrientation() {
        switch UIDevice.current.orientation {
        case .landscapeLeft, .landscapeRight:
            numberOfItemPerRow = 2
        default:
            numberOfItemPerRow = 1
        }
    }
    
    private func updateCollectionViewItemSize() {
        let lineSpacing: CGFloat = 0
        let interItemSpacing: CGFloat = 10
        let width = ((self.gameCollectionView.frame.size.width - (self.numberOfItemPerRow - 1) * interItemSpacing)) / self.numberOfItemPerRow
        let height = self.numberOfItemPerRow == 1 ? 100 : 110
        
        collectionViewFlowLayout.itemSize = CGSize(width: Int(width), height: height)
        collectionViewFlowLayout.sectionInset = UIEdgeInsets.zero
        collectionViewFlowLayout.scrollDirection = .vertical
        collectionViewFlowLayout.minimumLineSpacing = lineSpacing
        collectionViewFlowLayout.minimumInteritemSpacing = lineSpacing
    }
    
    private func setupCollectionViewLayout() {
        self.collectionViewFlowLayout = UICollectionViewFlowLayout()
        gameCollectionView.setCollectionViewLayout(self.collectionViewFlowLayout, animated: true)
    }
}
// MARK: - Extension HomeViewControllerProtocol
extension HomeViewController: HomeViewControllerProtocol {
    func reloadData() {
        DispatchQueue.main.async {
            self.gameCollectionView.reloadData()
        }
    }
    
    func setSliderImages(_ images: [String]) {
        NotificationCenter.default.post(name: Notification.Name("GetImages"), object: nil, userInfo: ["images": images])
    }
    
    func collectionViewRegister() {
        let uiNib = UINib(nibName: "VideoGameCollectionViewCell", bundle: nil)
        gameCollectionView.register(uiNib, forCellWithReuseIdentifier: "VideoGameCollectionViewCell")
    }
}
// MARK: - Extension UICollectionViewDelegate
extension HomeViewController: UICollectionViewDelegate {
    
}
// MARK: - Extension UICollectionViewDataSource
extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.presenter.numberOfVideoGames
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let dequeueReusableCell = collectionView.dequeueReusableCell(withReuseIdentifier: "VideoGameCollectionViewCell", for: indexPath)
        guard let cell = dequeueReusableCell as? VideoGameCollectionViewCell else { return UICollectionViewCell()}
        guard let videoGameCell = presenter.getVideoGameByIndex(indexPath.row) else { return cell }
        cell.cellPresenter = VideoGameCellPresenter(view: cell, videoGame: videoGameCell)
        return cell
    }
}
