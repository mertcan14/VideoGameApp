//
//  VideoGameListViewController.swift
//  VideoGameApp
//
//  Created by mertcan YAMAN on 31.07.2023.
//

import UIKit
// MARK: Protocol VideoGameListDisplayLogic
protocol VideoGameListDisplayLogic: AnyObject {
    func displayVideoGameList(viewModel: VideoGameList.FetchVideoGameList.ViewModel)
    func displayNextPage(viewModel: VideoGameList.FetchNextPage.ViewModel)
}
// MARK: Class VideoGameListViewController
final class VideoGameListViewController: BaseViewController {
    // MARK: - IBOutlet Definitions
    @IBOutlet weak var gameCollectionView: UICollectionView!
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var innerViewConstraint: NSLayoutConstraint!
    @IBOutlet weak var pageView: UIView!
    @IBOutlet weak var filtersButtonImageView: UIImageView!
    @IBOutlet weak var searhTextField: UITextField!
    
    // MARK: - Variable Definitions
    internal var interactor: VideoGameListBusinessLogic?
    internal var router: (
        NSObjectProtocol
        & VideoGameListRoutingLogic
        & VideoGameListDataPassing)?
    private var videoGames: [VideoGameNetworkModel] = []
    private var searchedVideoGames: [VideoGameNetworkModel] = []
    private var nextPage: String?
    private var landScapeAction: () -> Void = {}
    private var portraitAction: () -> Void = {}
    private var sliderCount: Int = 3
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.showLoading()
        self.interactor?.fetchVideoGameList()
        self.collectionViewRegister()
        self.setupCollectionViewLayout()
        self.configFiltersButton()
        self.setDeviceOrientation()
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(goDetailScreen(notification:)),
                                               name: Notification.Name("GoDetailScreen"),
                                               object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        checkDeviceOrientation(landScapeAction, portraitAction)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.searchView.addBottomBorderWithColor(color: .fieldColor, width: 2)
    }
    
    override func viewDidLayoutSubviews() {
        updateCollectionViewItemSize()
    }
    
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        checkDeviceOrientation(landScapeAction, portraitAction)
        updateBorderFromSearchView()
    }
}

extension VideoGameListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let id = isSearching
        ? searchedVideoGames[safe: indexPath.row]?.id
        : videoGames[safe: indexPath.row + sliderCount]?.id else { return }
        interactor?.setGameId(String(id))
        router?.routeToDetailVideoGame(segue: nil)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let height = self.gameCollectionView.contentSize.height - self.gameCollectionView.bounds.size.height
        if self.gameCollectionView.contentOffset.y >= height && isSearching == false {
            if !isPageRefreshing {
                guard let nextPage else { return }
                showLoading()
                isPageRefreshing = true
                interactor?.fetchNextPage(url: nextPage)
            }
        }
    }
}
// MARK: - Extension UICollectionViewDataSource
extension VideoGameListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let numberOfItem = isSearching
                ? self.searchedVideoGames.count
                : self.videoGames.count - sliderCount
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
                : self.videoGames[safe: indexPath.row + sliderCount] else { return cell }
        cell.videoGame = videoGameCell
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
        hidePageView(true)
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
    
    @objc func goDetailScreen(notification: Notification) {
        guard let imagesAny = notification.userInfo?["videoGameID"],
              let id = imagesAny as? String else { return }
        interactor?.setGameId(id)
        router?.routeToDetailVideoGame(segue: nil)
    }
    
    @objc func removeSearch() {
        hidePageView(false)
        isSearching = false
        reloadData()
    }
}
// MARK: Extension VideoGameListDisplayLogic
extension VideoGameListViewController: VideoGameListDisplayLogic {
    func displayNextPage(viewModel: VideoGameList.FetchNextPage.ViewModel) {
        guard let results = viewModel.results, let next = viewModel.next else { return }
        videoGames += results
        nextPage = next
        isPageRefreshing = false
        self.reloadData()
        self.hideLoading(0.5)
    }
    
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
// MARK: Extension For Private Funcs
extension VideoGameListViewController {
    private func setDeviceOrientation() {
        landScapeAction = {
            self.numberOfItemPerRow = self.numberOfItemPerRowLandscape
            self.innerViewConstraint.constant = self.heightOfInnerViewIsLandscapeConstant
        }
        
        portraitAction = {
            self.numberOfItemPerRow = self.numberOfItemPerRowPortrait
            self.innerViewConstraint.constant = self.heightOfInnerViewIsPortrait
        }
    }
    
    private func hidePageView(_ isHide: Bool) {
        DispatchQueue.main.async {
            self.pageView.isHidden = isHide
        }
    }
    
    private func reloadData() {
        DispatchQueue.main.async {
            self.gameCollectionView.reloadData()
        }
    }
    
    private func setupCollectionViewLayout() {
        self.collectionViewFlowLayout = UICollectionViewFlowLayout()
        gameCollectionView.setCollectionViewLayout(self.collectionViewFlowLayout, animated: true)
    }
    
    private func setSliderImages(_ videoGame: [VideoGameNetworkModel]) {
        NotificationCenter.default.post(name: Notification.Name("GetvideoGames"), object: nil, userInfo: ["videoGame": videoGame])
    }
    
    private func collectionViewRegister() {
        gameCollectionView.register(cellType: VideoGameCollectionViewCell.self)
    }
    
    private func configFiltersButton() {
        let tapFilter = UITapGestureRecognizer(target: self, action: #selector(tapFilter))
        filtersButtonImageView.addGestureRecognizer(tapFilter)
    }
    
    private func setImagesForSlider() {
        if videoGames.count > sliderCount {
            self.hidePageView(false)
            self.setSliderImages(Array(self.videoGames.prefix(upTo: sliderCount)))
        } else {
            self.hidePageView(true)
        }
    }
    
    private func updateCollectionViewItemSize() {
        let width = (self.view.safeAreaLayoutGuide.layoutFrame.width - 24 - ((numberOfItemPerRow - 1) * 6))
        / self.numberOfItemPerRow
        let height = self.numberOfItemPerRow == 1 ? heightCellIsPortrait
        : heightCellIsLandscape
        
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
        let vc = FiltersViewController()
        vc.interactor = interactor
        let navVC = UINavigationController(rootViewController: vc)

        if let sheet = navVC.sheetPresentationController {
            sheet.detents = [.custom(resolver: { _ in
                return 350
            }), .custom(resolver: { context in
                return context.maximumDetentValue * 0.6
            })]
            sheet.prefersScrollingExpandsWhenScrolledToEdge = false
        }
        present(navVC, animated: true)
    }
}
