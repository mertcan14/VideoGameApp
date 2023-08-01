//
//  FavoritesViewController.swift
//  VideoGameApp
//
//  Created by mertcan YAMAN on 20.07.2023.
//

import UIKit

// MARK: Protocol FavoritesViewControllerProtocol
protocol FavoritesViewControllerProtocol: BaseViewControllerProtocol {
    func reloadData()
    func setupCollectionViewLayout()
    func collectionViewRegister()
}
// MARK: Class FavoritesViewController
final class FavoritesViewController: BaseViewController {
    // MARK: - IBOutlet Definitions
    @IBOutlet weak var videoGamesCollectionView: UICollectionView!
    // MARK: - Variable Definitions
    public var presenter: FavoritesPresenterProtocol!
    private var collectionViewFlowLayout: UICollectionViewFlowLayout!
    private var numberOfItemPerRow: CGFloat = 1
    private let lineSpacingForCollectionView: CGFloat = 0
    private let heightCellIsLandscape: Int = 100
    private let heightCellIsPortrait: Int = 110
    private let numberItemPerRowPortrait: CGFloat = 1
    private let numberItemPerRowLandscape: CGFloat = 2
    private let titleOfEmptyView: String = "Sorry"
    private let messageOfEmptyView: String = "The game you were looking for was not found"
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
        
        videoGamesCollectionView.dataSource = self
        videoGamesCollectionView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        checkDeviceOrientation()
        presenter.viewWillAppear()
    }
    
    override func viewDidLayoutSubviews() {
        updateCollectionViewItemSize()
    }
    
    override func willTransition(to newCollection: UITraitCollection,
                                 with coordinator: UIViewControllerTransitionCoordinator) {
        checkDeviceOrientation()
    }
    // MARK: - Private Funcs
    private func checkDeviceOrientation() {
        guard let deviceOrientation = UIApplication.shared.currentUIWindow()?
            .windowScene?.interfaceOrientation else { return }
        if deviceOrientation.isLandscape {
            self.numberOfItemPerRow = numberItemPerRowLandscape
        } else {
            self.numberOfItemPerRow = numberItemPerRowPortrait
        }
    }
    
    private func updateCollectionViewItemSize() {
        let width = self.view.safeAreaLayoutGuide.layoutFrame.width / self.numberOfItemPerRow
        let height = self.numberOfItemPerRow == numberItemPerRowPortrait ? heightCellIsPortrait
        : heightCellIsLandscape
        
        collectionViewFlowLayout.itemSize = CGSize(width: Int(width - 4), height: height)
        collectionViewFlowLayout.sectionInset = UIEdgeInsets.zero
        collectionViewFlowLayout.scrollDirection = .vertical
        collectionViewFlowLayout.minimumLineSpacing = lineSpacingForCollectionView
        collectionViewFlowLayout.minimumInteritemSpacing = lineSpacingForCollectionView
    }
}
// MARK: - Extension FavoritesViewControllerProtocol
extension FavoritesViewController: FavoritesViewControllerProtocol {
    func reloadData() {
        DispatchQueue.main.async { [weak self] in
            self?.videoGamesCollectionView.reloadData()
        }
    }
    
    func setupCollectionViewLayout() {
        self.collectionViewFlowLayout = UICollectionViewFlowLayout()
        videoGamesCollectionView.setCollectionViewLayout(self.collectionViewFlowLayout, animated: true)
    }
    
    func collectionViewRegister() {
        videoGamesCollectionView.register(cellType: VideoGameCollectionViewCell.self)
    }
}
// MARK: - Extension UICollectionViewDelegate
extension FavoritesViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.presenter.goDetailScreen(indexPath.row)
    }
}
// MARK: - Extension UICollectionViewDataSource
extension FavoritesViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let numberOfItem = presenter.numberOfVideoGame
        if numberOfItem == 0 {
            collectionView.setEmptyView(title: titleOfEmptyView, message: messageOfEmptyView)
        } else {
            collectionView.restore()
        }
        return numberOfItem
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(indexPath: indexPath as NSIndexPath, cellType: VideoGameCollectionViewCell.self)
        guard let videoGameCell = presenter.getVideoGameByIndex(indexPath.row) else { return cell}
        cell.cellPresenter = VideoGameCellPresenter(view: cell, videoGame: videoGameCell)
        return cell
    }
}
