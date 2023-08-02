//
//  VideGameDetailViewController.swift
//  VideoGameApp
//
//  Created by mertcan YAMAN on 2.08.2023.
//

import UIKit

protocol VideoGameDetailDisplayLogic: AnyObject {
    func displayVideoGameList(viewModel: VideoGameDetailModels.FetchVideoGameDetail.ViewModel)
    func displayIsLikedVideoGame(viewModel: VideoGameDetailModels.FetchIsLikedVideoGame.ViewModel)
}

final class VideoGameDetailViewController: BaseViewController {
    // MARK: - IBOutlet Definitions   
//    @IBOutlet weak var realesedDateLabel: UILabel!
//    @IBOutlet weak var lowerStackView: UIStackView!
//    @IBOutlet weak var upperStackView: UIStackView!
//    @IBOutlet weak var releasedView: UIView!
//    @IBOutlet weak var metacriticRateLabel: UILabel!
//    @IBOutlet weak var metacriticView: UIView!
//    @IBOutlet weak var webOfGameImageView: UIImageView!
//    @IBOutlet weak var gameNameLabel: UILabel!
//    @IBOutlet weak var descriptionLabel: UILabel!
//    @IBOutlet weak var infoStackView: UIStackView!
//    @IBOutlet weak var gameImageView: UIImageView!
//    @IBOutlet weak var backButtonImageView: UIImageView!
//    @IBOutlet weak var likeButtonImageView: UIImageView!  
    
    // MARK: - Variable Definitions
    internal var interactor: VideoGameDetailBusinessLogic?
    internal var router: (NSObjectProtocol &
                          VideoGameDetailRoutingLogic &
                          VideoGameDetailDataPassing)?
    
    private var videoGame: DetailVideoGameNetworkModel?
    private var isLiked: Bool = false
    private let descriptionLabelFontSize: CGFloat = 16
    private let arrowImageIsDark: UIImage = .arrowW
    private let arrowImageNoDark: UIImage = .arrow
    private let likedImage: UIImage = .likedicon
    private let likeImageIsDark: UIImage = .likeiconW
    private let likeImageNoDark: UIImage = .likeicon
    private let notFoundImage: UIImage = .noimage
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
        //self.showLoading()
//        self.configBackButton()
//        self.configLikeButton()
//        self.configureWebOfGameImageView()
        self.interactor?.fetchVideoGameDetail()
        self.interactor?.fetchIsLikeVideoGame()
    }
    
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
//        checkDeviceOrientation()
    }
    // MARK: - Private Funcs
//    func checkDeviceOrientation() {
//        guard let deviceOrientation = UIApplication.shared.currentUIWindow()?
//            .windowScene?.interfaceOrientation else { return }
//        if deviceOrientation.isLandscape {
//            DispatchQueue.main.async { [weak self] in
//                guard let self else { return }
//                self.infoStackView.removeFromSuperview()
//                self.upperStackView.insertArrangedSubview(infoStackView, at: 1)
//            }
//        } else {
//            DispatchQueue.main.async { [weak self] in
//                guard let self else { return }
//                self.infoStackView.removeFromSuperview()
//                self.lowerStackView.insertArrangedSubview(infoStackView, at: 0)
//            }
//        }
//    }
//
//    private func hideMetacriticView(_ isHide: Bool) {
//        DispatchQueue.main.async { [weak self] in
//            self?.metacriticView.isHidden = isHide
//        }
//    }
//
//    private func hideReleasedView(_ isHide: Bool) {
//        DispatchQueue.main.async { [weak self] in
//            self?.releasedView.isHidden = isHide
//        }
//    }
//
//    private func setBackImageView(_ isDark: Bool) {
//        DispatchQueue.main.async { [weak self] in
//            guard let self else { return }
//            self.backButtonImageView.image = isDark ? self.arrowImageIsDark
//            : self.arrowImageNoDark
//        }
//    }
//
//    private func setLikeImageView(_ isDark: Bool) {
//        DispatchQueue.main.async { [weak self] in
//            guard let self else { return }
//            self.likeButtonImageView.image = isDark ? self.likeImageIsDark
//            : self.likeImageNoDark
//        }
//    }
//
//    @objc private func goBackScreen() {
//        //presenter.goBackScreen()
//    }
//
//    @objc private func goWeb() {
//        //presenter.goWebsite()
//    }
//
//    @objc private func liked() {
//        //presenter.likeVideoGame()
//    }
//
//    func hideWebOfGameImageView(_ isHide: Bool) {
//        DispatchQueue.main.async { [weak self] in
//            self?.webOfGameImageView.isHidden = isHide
//        }
//    }
//
//    func configBackButton() {
//        let backTap = UITapGestureRecognizer(target: self, action: #selector(goBackScreen))
//        backButtonImageView.addGestureRecognizer(backTap)
//    }
//
//    func configureWebOfGameImageView() {
//        let goWeb = UITapGestureRecognizer(target: self, action: #selector(goWeb))
//        webOfGameImageView.addGestureRecognizer(goWeb)
//    }
//
//    func configLikeButton() {
//        let likeButton = UITapGestureRecognizer(target: self, action: #selector(liked))
//        likeButtonImageView.addGestureRecognizer(likeButton)
//    }
//
//    func unLikedVideoGame() {
//        guard let image = gameImageView.image else { return }
//        DispatchQueue.main.async { [weak self] in
//            self?.setLikeImageView(image.isDark(.bottomRight))
//        }
//    }
//
//    func isLikedVideoGame(_ isLiked: Bool) {
//        DispatchQueue.main.async { [weak self] in
//            self?.likeButtonImageView.image = self?.likedImage
//        }
//    }
//
//    func setImageView(_ image: String?) {
//        guard let image, let url = URL(string: image) else {
//            DispatchQueue.main.async { [weak self] in
//                guard let self else { return }
//                self.gameImageView.image = .noimage
//                if true {
//                    self.setLikeImageView(false)
//                }
//                self.setBackImageView(false)
//                self.gameImageView.contentMode = .scaleAspectFill
//            }
//            return
//        }
//        self.gameImageView.downloadedWithCompletion(from: url) {[weak self] image in
//            guard let self else { return }
//            guard let image else {
//                self.gameImageView.image = notFoundImage
//                return
//            }
//            if true {
//                self.setLikeImageView(image.isDark(.bottomRight))
//            }
//            self.setBackImageView(image.isDark(.leftTop))
//            self.gameImageView.contentMode = .scaleAspectFill
//        }
//    }
//
//    func setGameName(_ name: String?) {
//        DispatchQueue.main.async { [weak self] in
//            self?.checkDeviceOrientation()
//            self?.gameNameLabel.text = name
//        }
//    }
//
//    func setReleasedDate(_ date: String?) {
//        guard let date else {
//            hideReleasedView(true)
//            return
//        }
//        DispatchQueue.main.async { [weak self] in
//            self?.realesedDateLabel.text = date
//        }
//    }
//
//    func setMetacriticRate(_ metaCriticRate: Int?) {
//        guard let point = metaCriticRate else {
//            hideMetacriticView(true)
//            return
//        }
//        DispatchQueue.main.async { [weak self] in
//            self?.metacriticRateLabel.text = "\(point)"
//        }
//    }
//
//    private func setImages() {
//        self.setImageView(videoGame?.backgroundImage)
//    }
//
//    private func checkWebOfGame() {
//        self.hideWebOfGameImageView(videoGame?.website == "")
//    }
//
//    func setDescription(_ description: String?) {
//        guard let description else {
//            self.descriptionLabel.text = "No description."
//            return
//        }
//        DispatchQueue.main.async { [weak self] in
//            guard let self else { return }
//            self.descriptionLabel.attributedText = description.htmlToAttributedString
//            self.descriptionLabel.font = self.descriptionLabel.font.withSize(self.descriptionLabelFontSize)
//            if self.traitCollection.userInterfaceStyle == .dark {
//                self.descriptionLabel.textColor = .white
//            }
//        }
//    }
}

extension VideoGameDetailViewController: VideoGameDetailDisplayLogic {
    func displayIsLikedVideoGame(viewModel: VideoGameDetailModels.FetchIsLikedVideoGame.ViewModel) {
//        self.isLikedVideoGame(viewModel.isLike)
        self.isLiked = viewModel.isLike
    }
    
    func displayVideoGameList(viewModel: VideoGameDetailModels.FetchVideoGameDetail.ViewModel) {
        self.videoGame = viewModel.results
        self.hideLoading()
//        setImages()
//        checkWebOfGame()
//        self.setDescription(videoGame?.description)
//        self.setMetacriticRate(videoGame?.metacritic)
//        self.setGameName(videoGame?.name)
//        self.setReleasedDate(videoGame?.released)
        self.hideLoading()
    }
}
