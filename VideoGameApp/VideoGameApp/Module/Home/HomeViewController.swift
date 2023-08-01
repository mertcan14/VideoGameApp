//
//  HomeViewController.swift
//  VideoGameApp
//
//  Created by mertcan YAMAN on 14.07.2023.
//

import UIKit

// MARK: Protocol HomeViewControllerProtocol
protocol HomeViewControllerProtocol: BaseViewControllerProtocol {
    func setSliderImages(_ videoGame: [VideoGame])
    func collectionViewRegister()
    func reloadData()
    func hidePageView()
    func showPageView()
    func setupCollectionViewLayout()
    func setPageRefreshing()
    func configFiltersButton()
}
// MARK: Class HomeViewController
final class HomeViewController: BaseViewController {
    // MARK: - IBOutlet Definitions
    @IBOutlet weak var gameCollectionView: UICollectionView!
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var innerViewConstraint: NSLayoutConstraint!
    @IBOutlet weak var pageView: UIView!
    @IBOutlet weak var filtersButtonImageView: UIImageView!
    @IBOutlet weak var searhTextField: UITextField!
    
    // MARK: - Variable Definitions
    public var presenter: HomePresenterProtocol!
    private var collectionViewFlowLayout: UICollectionViewFlowLayout!
    private var numberOfItemPerRow: CGFloat = 1
    private var isSearching = false
    private var isPageRefreshing: Bool = false
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
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        checkDeviceOrientation()
        if presenter.numberOfVideoGames == 0 {
            self.showLoading()
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
        collectionViewFlowLayout.sectionInset = UIEdgeInsets.zero
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
        vc.presenter = FiltersPresenter(view: vc, interactor: presenter.getInteractor())
        let navVC = UINavigationController(rootViewController: vc)

        if let sheet = navVC.sheetPresentationController {
            sheet.detents = [.custom(resolver: { _ in
                return 350
            }), .custom(resolver: { context in
                return context.maximumDetentValue * 0.6
            })]
            sheet.prefersScrollingExpandsWhenScrolledToEdge = false
        }
        navigationController?.present(navVC, animated: true)
    }
}
// MARK: - Extension HomeViewControllerProtocol
extension HomeViewController: HomeViewControllerProtocol {
    func setPageRefreshing() {
        self.isPageRefreshing = false
    }
    
    func hidePageView() {
        DispatchQueue.main.async { [weak self] in
            self?.pageView.isHidden = true
        }
    }
    
    func showPageView() {
        DispatchQueue.main.async { [weak self] in
            self?.pageView.isHidden = false
        }
    }
    
    func reloadData() {
        DispatchQueue.main.async { [weak self] in
            self?.gameCollectionView.reloadData()
        }
    }
    
    func setupCollectionViewLayout() {
        self.collectionViewFlowLayout = UICollectionViewFlowLayout()
        gameCollectionView.setCollectionViewLayout(self.collectionViewFlowLayout, animated: true)
    }
    
    func setSliderImages(_ videoGame: [VideoGame]) {
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
// MARK: - Extension UICollectionViewDelegate
extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.presenter.goDetailScreen(indexPath.row, isSearching)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let height = self.gameCollectionView.contentSize.height - self.gameCollectionView.bounds.size.height
        if self.gameCollectionView.contentOffset.y >= height, isSearching == false {
            if !isPageRefreshing {
                isPageRefreshing = true
                presenter.fetchNextPage()
            }
        }
    }
}
// MARK: - Extension UICollectionViewDataSource
extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let numberOfItem = isSearching ? self.presenter.numberOfSearchedVideoGames : self.presenter.numberOfVideoGames - presenter.numberOfSlide
        if numberOfItem < 0 {
            collectionView.setEmptyView(title: titleOfEmptyView, message: messageOfEmptyView)
        } else {
            collectionView.restore()
        }
        return numberOfItem
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(indexPath: indexPath as NSIndexPath, cellType: VideoGameCollectionViewCell.self)
        guard let videoGameCell = isSearching ? presenter.getSearchedVideoGameByIndex(indexPath.row)
                : presenter.getVideoGameByIndex(indexPath.row + presenter.numberOfSlide) else { return cell }
        cell.cellPresenter = VideoGameCellPresenter(view: cell, videoGame: videoGameCell)
        return cell
    }
}
// MARK: - Extension UITextFieldDelegate
extension HomeViewController: UITextFieldDelegate {
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
        presenter.searchVideoGame(text.lowercased())
        isSearching = true
    }
    
    @objc func removeSearch() {
        showPageView()
        isSearching = false
        reloadData()
    }
}
