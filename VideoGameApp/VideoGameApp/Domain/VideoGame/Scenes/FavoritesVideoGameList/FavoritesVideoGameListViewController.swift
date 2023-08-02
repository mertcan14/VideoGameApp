//
//  FavoritesVideoGameListViewController.swift
//  VideoGameApp
//
//  Created by mertcan YAMAN on 2.08.2023.
//

import UIKit

protocol FavoritesVideoGameListDisplayLogic: AnyObject {
    func displayVideoGameList(viewModel: FavoritesVideoGameList.FetchVideoGameListFromCoreData.ViewModel)
}

final class FavoritesVideoGameListViewController: BaseViewController {
    // MARK: - IBOutlet Definitions
    @IBOutlet weak var videoGamesCollectionView: UICollectionView!
    // MARK: - Variable Definitions
    private var videoGames: [VideoGameNetworkModel] = []
    internal var interactor: FavoritesVideoGameListBusinessLogic?
    internal var router: (NSObjectProtocol &
                          FavoritesVideoGameListRoutingLogic &
                          FavoritesVideoGameListDataPassing)?
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
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
      super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
      setup()
    }

    required init?(coder aDecoder: NSCoder) {
      super.init(coder: aDecoder)
      setup()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionViewRegister()
        self.setupCollectionViewLayout()
        self.showLoading()
        interactor?.fetchFavoritesVideoGameList()
        
        videoGamesCollectionView.dataSource = self
        videoGamesCollectionView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        checkDeviceOrientation()
        //presenter.viewWillAppear()
    }
    
    override func viewDidLayoutSubviews() {
        updateCollectionViewItemSize()
    }
    
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
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
        let height = self.numberOfItemPerRow == numberItemPerRowPortrait ? heightCellIsPortrait : heightCellIsLandscape
        
        collectionViewFlowLayout.itemSize = CGSize(width: Int(width - 4), height: height)
        collectionViewFlowLayout.sectionInset = UIEdgeInsets.zero
        collectionViewFlowLayout.scrollDirection = .vertical
        collectionViewFlowLayout.minimumLineSpacing = lineSpacingForCollectionView
        collectionViewFlowLayout.minimumInteritemSpacing = lineSpacingForCollectionView
    }
    
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

extension FavoritesVideoGameListViewController: FavoritesVideoGameListDisplayLogic {
    func displayVideoGameList(viewModel: FavoritesVideoGameList.FetchVideoGameListFromCoreData.ViewModel) {
        guard let results = viewModel.results else { return }
        self.videoGames = results
        self.hideLoading(0.5)
        reloadData()
    }
}

// MARK: - Extension UICollectionViewDelegate
extension FavoritesVideoGameListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //self.presenter.goDetailScreen(indexPath.row)
    }
}
// MARK: - Extension UICollectionViewDataSource
extension FavoritesVideoGameListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if videoGames.isEmpty {
            collectionView.setEmptyView(title: titleOfEmptyView, message: messageOfEmptyView)
            return 0
        } else {
            collectionView.restore()
        }
        return videoGames.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(indexPath: indexPath as NSIndexPath, cellType: VideoGameCollectionViewCell.self)
        guard let videoGameCell = videoGames[safe: indexPath.row] else { return cell}
        cell.videoGame = videoGameCell
        return cell
    }
}
