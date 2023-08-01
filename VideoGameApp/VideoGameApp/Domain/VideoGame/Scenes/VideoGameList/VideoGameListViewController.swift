//
//  VideoGameListViewController.swift
//  VideoGameApp
//
//  Created by mertcan YAMAN on 31.07.2023.
//

import UIKit

protocol VideoGameListDisplayLogic: AnyObject {
    func displayVideoGameList(viewModel: VideoGameList.FetchVideoGameList.ViewModel)
}

final class VideoGameListViewController: BaseViewController {
    var interactor: VideoGameListBusinessLogic?
    var router: (NSObjectProtocol & VideoGameListRoutingLogic & VideoGameListDataPassing)?
    
    // MARK: - IBOutlet Definitions
    @IBOutlet weak var gameCollectionView: UICollectionView!
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var innerViewConstraint: NSLayoutConstraint!
    @IBOutlet weak var pageView: UIView!
    @IBOutlet weak var filtersButtonImageView: UIImageView!
    @IBOutlet weak var searhTextField: UITextField!
    
    // MARK: - Variable Definitions
    private var videoGames: [VideoGameNetworkModel] = []
    private var searchedVideoGames: [VideoGameNetworkModel] = []
    private var nextPage: String?
    private let lineSpacingForCollectionView: CGFloat = 0
    private let heightCellIsLandscape: Int = 100
    private let heightCellIsPortrait: Int = 110
    private let heightOfInnerViewIsLandscapeConstant: CGFloat = 150
    private let heightOfInnerViewIsPortrait: CGFloat = -52
    private let requiredWordToSearch: Int = 3
    private let titleOfEmptyView: String = "Sorry"
    private let messageOfEmptyView: String = "The game you were looking for was not found"
    private var numberOfItemPerRowPortrait: CGFloat = 1
    private var numberOfItemPerRowLandscape: CGFloat = 2
    private var collectionViewFlowLayout: UICollectionViewFlowLayout!
    private var numberOfItemPerRow: CGFloat = 1
    private var isSearching = false
    private var isPageRefreshing: Bool = false
    
    // MARK: - Lifecycle Methods
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
      super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
      setup()
    }

    required init?(coder aDecoder: NSCoder) {
      super.init(coder: aDecoder)
      setup()
    }
    
    private func setup() {
        let viewController = self
        let interactor = VideoGameListInteractor()
        let presenter = VideoGameListPresenter()
        let router = VideoGameListRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.interactor?.fetchVideoGameList()
        self.collectionViewRegister()
        self.setupCollectionViewLayout()
        self.configFiltersButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.showLoading()
        checkDeviceOrientation()
        if videoGames.isEmpty {
            //self.showLoading()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.searchView.addBottomBorderWithColor(color: .fieldColor, width: 2)
    }
    
    override func viewDidLayoutSubviews() {
        updateCollectionViewItemSize()
    }
    
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        checkDeviceOrientation()
        updateBorderFromSearchView()
    }
    
    // MARK: - Funcs For Configure
    private func setImagesForSlider() {
        if videoGames.count > 3 {
            self.showPageView()
            self.setSliderImages(Array(self.videoGames.prefix(upTo: 3)))
        } else {
            self.hidePageView()
        }
    }
    
    private func checkDeviceOrientation() {
        guard let deviceOrientation = UIApplication.shared.currentUIWindow()?
            .windowScene?.interfaceOrientation else { return }
        if deviceOrientation.isLandscape {
            self.numberOfItemPerRow = numberOfItemPerRowLandscape
            innerViewConstraint.constant = heightOfInnerViewIsLandscapeConstant
        } else {
            self.numberOfItemPerRow = numberOfItemPerRowPortrait
            innerViewConstraint.constant = heightOfInnerViewIsPortrait
        }
    }
    
    private func updateCollectionViewItemSize() {
        let width = (self.view.safeAreaLayoutGuide.layoutFrame.width - 24 - ((numberOfItemPerRow - 1) * 6)) / self.numberOfItemPerRow
        let height = self.numberOfItemPerRow == 1 ? heightCellIsPortrait : heightCellIsLandscape
        
        collectionViewFlowLayout.itemSize = CGSize(width: Int(width), height: height)
        collectionViewFlowLayout.sectionInset = .zero
        collectionViewFlowLayout.scrollDirection = .vertical
        collectionViewFlowLayout.minimumLineSpacing = lineSpacingForCollectionView
        collectionViewFlowLayout.minimumInteritemSpacing = lineSpacingForCollectionView
    }
    
    private func updateBorderFromSearchView() {
        DispatchQueue.main.async {
            self.searchView.updateBottomBorderWithColor(color: .fieldColor, width: 2)
        }
    }
    
    @objc private func tapFilter() {
//        let vc = FiltersViewController()
//        vc.presenter = FiltersPresenter(view: vc, interactor: presenter.getInteractor())
//        let navVC = UINavigationController(rootViewController: vc)
//
//        if let sheet = navVC.sheetPresentationController {
//            sheet.detents = [.custom(resolver: { context in
//                return context.maximumDetentValue * 0.4
//            }), .custom(resolver: { context in
//                return context.maximumDetentValue * 0.6
//            })]
//            sheet.prefersScrollingExpandsWhenScrolledToEdge = false
//        }
//        navigationController?.present(navVC, animated: true)
    }
}

extension VideoGameListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //self.presenter.goDetailScreen(indexPath.row, isSearching)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let height = self.gameCollectionView.contentSize.height - self.gameCollectionView.bounds.size.height
        if self.gameCollectionView.contentOffset.y >= height && isSearching == false {
            if !isPageRefreshing {
                isPageRefreshing = true
                //presenter.fetchNextPage()
            }
        }
    }
}
// MARK: - Extension UICollectionViewDataSource
extension VideoGameListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let numberOfItem = isSearching
                ? self.searchedVideoGames.count
                : self.videoGames.count
        if numberOfItem < 0 {
            collectionView.setEmptyView(title: titleOfEmptyView, message: messageOfEmptyView)
        } else {
            collectionView.restore()
        }
        return numberOfItem
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(indexPath: indexPath as NSIndexPath, cellType: VideoGameCollectionViewCell.self)
        guard let videoGameCell = isSearching
                ? self.searchedVideoGames[safe: indexPath.row]
                : self.videoGames[safe: indexPath.row] else { return cell }
        cell.cellPresenter = VideoGameCellPresenter(view: cell, videoGame: videoGameCell)
        return cell
    }
}
// MARK: - Extension UITextFieldDelegate
extension VideoGameListViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else { return true }
        if string.charIsSpace(), !string.charIsBackSpace(), text.isEmpty {
            return false
        }
        let currentText = (text as NSString).replacingCharacters(in: range, with: string)
        if currentText.count >= requiredWordToSearch {
            performSearch(currentText)
        } else {
            isSearching ? removeSearch() : nil
        }
        return true
    }
    
    @objc func performSearch(_ text: String) {
        hidePageView()
        searchedVideoGames = []
        videoGames.forEach { [weak self] videoGame in
            guard let name = videoGame.name else { return }
            if name.lowercased().contains(text.lowercased()) {
                self?.searchedVideoGames.append(videoGame)
            }
        }
        reloadData()
        isSearching = true
    }
    
    @objc func removeSearch() {
        showPageView()
        isSearching = false
        reloadData()
    }
}

extension VideoGameListViewController: VideoGameListDisplayLogic {
    func displayVideoGameList(viewModel: VideoGameList.FetchVideoGameList.ViewModel) {
        guard let results = viewModel.results, let next = viewModel.next else { return }
        ImageProvider.shared.refreshCache()
        videoGames = results
        nextPage = next
        setImagesForSlider()
        self.reloadData()
        self.hideLoading(0.5)
    }
}

extension VideoGameListViewController {
    func setPageRefreshing() {
        self.isPageRefreshing = false
    }
    
    func hidePageView() {
        DispatchQueue.main.async {
            self.pageView.isHidden = true
        }
    }
    
    func showPageView() {
        DispatchQueue.main.async {
            self.pageView.isHidden = false
        }
    }
    
    func reloadData() {
        DispatchQueue.main.async {
            self.gameCollectionView.reloadData()
        }
    }
    
    func setupCollectionViewLayout() {
        self.collectionViewFlowLayout = UICollectionViewFlowLayout()
        gameCollectionView.setCollectionViewLayout(self.collectionViewFlowLayout, animated: true)
    }
    
    func setSliderImages(_ videoGame: [VideoGameNetworkModel]) {
        NotificationCenter.default.post(name: Notification.Name("GetvideoGames"), object: nil, userInfo: ["videoGame": videoGame])
    }
    
    func collectionViewRegister() {
        gameCollectionView.register(cellType: VideoGameCollectionViewCell.self)
    }
    
    func configFiltersButton() {
        let tapFilter = UITapGestureRecognizer(target: self, action: #selector(tapFilter))
        filtersButtonImageView.addGestureRecognizer(tapFilter)
    }
}
