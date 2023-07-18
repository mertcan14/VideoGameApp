//
//  HomeViewController.swift
//  VideoGameApp
//
//  Created by mertcan YAMAN on 14.07.2023.
//

import UIKit

private let slideCount: Int = 3

// MARK: Protocol BaseViewControllerProtocol
protocol HomeViewControllerProtocol: BaseViewControllerProtocol {
    func setSliderImages(_ videoGame: [VideoGame])
    func collectionViewRegister()
    func reloadData()
    func hidePageView()
    func showPageView()
}
// MARK: Class HomeViewController
final class HomeViewController: BaseViewController {
    // MARK: - IBOutlet Definitions
    @IBOutlet weak var gameCollectionView: UICollectionView!
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var innerViewConstraint: NSLayoutConstraint!
    @IBOutlet weak var pageView: UIView!
    @IBOutlet weak var searhTextField: UITextField!
    
    // MARK: - Variable Definitions
    public var presenter: HomePresenterProtocol!
    private var collectionViewFlowLayout: UICollectionViewFlowLayout!
    private var numberOfItemPerRow: CGFloat = 1
    private var timer: Timer?
    private var isSearching = false
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter.viewDidLoad()
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
        checkDeviceOrientation()
    }
    
    // MARK: - Funcs For Configure
    private func checkDeviceOrientation() {
        
        guard let deviceOrientation = UIApplication.shared.currentUIWindow()?
            .windowScene?.interfaceOrientation else { return }
        if deviceOrientation.isLandscape {
            self.numberOfItemPerRow = 2
            innerViewConstraint.constant = 200
        } else {
            self.numberOfItemPerRow = 1
            innerViewConstraint.constant = 0
        }
    }
    
    private func updateCollectionViewItemSize() {
        let lineSpacing: CGFloat = 0
        let width = self.view.safeAreaLayoutGuide.layoutFrame.width / self.numberOfItemPerRow
        let height = self.numberOfItemPerRow == 1 ? 100 : 110
        
        collectionViewFlowLayout.itemSize = CGSize(width: Int(width - 24), height: height)
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
    
    func setSliderImages(_ videoGame: [VideoGame]) {
        NotificationCenter.default.post(name: Notification.Name("GetImages"), object: nil, userInfo: ["videoGame": videoGame])
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
        isSearching ? self.presenter.numberOfSearchedVideoGames : self.presenter.numberOfVideoGames - slideCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let dequeueReusableCell = collectionView.dequeueReusableCell(withReuseIdentifier: "VideoGameCollectionViewCell", for: indexPath)
        guard let cell = dequeueReusableCell as? VideoGameCollectionViewCell else { return UICollectionViewCell()}
        guard let videoGameCell = isSearching ? presenter.getSearchedVideoGameByIndex(indexPath.row)
                : presenter.getVideoGameByIndex(indexPath.row + slideCount) else { return cell}
        cell.cellPresenter = VideoGameCellPresenter(view: cell, videoGame: videoGameCell)
        return cell
    }
}

extension HomeViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        timer?.invalidate()
        let currentText = textField.text ?? ""
        if (currentText as NSString).replacingCharacters(in: range, with: string).count >= 3 {
            timer = Timer.scheduledTimer(
                timeInterval: 0.5,
                target: self,
                selector: #selector(performSearch),
                userInfo: nil,
                repeats: false)
        } else {
            timer = Timer.scheduledTimer(
                timeInterval: 0.5,
                target: self,
                selector: #selector(removeSearch),
                userInfo: nil,
                repeats: false)
        }
        return true
    }
    
    @objc func performSearch() {
        guard let text = searhTextField.text else { return }
        presenter.searchVideoGame(text.lowercased())
        isSearching = true
    }
    
    @objc func removeSearch() {
        showPageView()
        isSearching = false
        reloadData()
    }
}
