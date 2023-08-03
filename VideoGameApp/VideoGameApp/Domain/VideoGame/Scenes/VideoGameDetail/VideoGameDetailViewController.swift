//
//  VideGameDetailViewController.swift
//  VideoGameApp
//
//  Created by mertcan YAMAN on 2.08.2023.
//

import UIKit

protocol VideoGameDetailDisplayLogic: AnyObject {
    func displayVideoGameList(viewModel: VideoGameDetailModels.FetchVideoGameDetail.ViewModel)
    func displayIsLikedVideoGame(isLike: Bool)
    func getError(_ content: String)
}

final class VideoGameDetailViewController: BaseViewController {
    // MARK: - IBOutlet Definitions
    @IBOutlet weak var realesedDateLabel: UILabel!
    @IBOutlet weak var lowerStackView: UIStackView!
    @IBOutlet weak var upperStackView: UIStackView!
    @IBOutlet weak var releasedView: UIView!
    @IBOutlet weak var metacriticRateLabel: UILabel!
    @IBOutlet weak var metacriticView: UIView!
    @IBOutlet weak var webOfGameImageView: UIImageView!
    @IBOutlet weak var gameNameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var infoStackView: UIStackView!
    @IBOutlet weak var gameImageView: UIImageView!
    @IBOutlet weak var backButtonImageView: UIImageView!
    @IBOutlet weak var likeButtonImageView: UIImageView!
    
    // MARK: - Variable Definitions
    internal var interactor: VideoGameDetailBusinessLogic?
    internal var router: (NSObjectProtocol &
                          VideoGameDetailRoutingLogic &
                          VideoGameDetailDataPassing)?
    
    private var videoGame: DetailVideoGameNetworkModel?
    private var isLiked: Bool = false
    private var landScapeAction: () -> Void = {}
    private var portraitAction: () -> Void = {}
    private let descriptionLabelFontSize: CGFloat = 16
    private let arrowImageIsDark: UIImage = .arrowW
    private let arrowImageNoDark: UIImage = .arrow
    private let likedImage: UIImage = .likedicon
    private let likeImageIsDark: UIImage = .likeiconW
    private let likeImageNoDark: UIImage = .likeicon
    private let notFoundImage: UIImage = .noimage
    private let titleOfPopUpForUnLike = "Are you sure?"
    private let contentOfPopUpForUnLike = "You are about to deregister the game"
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
        self.configBackButton()
        self.configLikeButton()
        self.configureWebOfGameImageView()
        self.interactor?.fetchVideoGameDetail()
        self.interactor?.fetchIsLikeVideoGame()
        
        landScapeAction = {
            DispatchQueue.main.async { [weak self] in
                guard let self else { return }
                infoStackView.removeFromSuperview()
                upperStackView.insertArrangedSubview(infoStackView, at: 1)
            }
        }
        
        portraitAction = {
            DispatchQueue.main.async { [weak self] in
                guard let self else { return }
                self.infoStackView.removeFromSuperview()
                self.lowerStackView.insertArrangedSubview(infoStackView, at: 0)
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.showLoading()
    }
    
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        checkDeviceOrientation(landScapeAction, portraitAction)
    }
    // MARK: - Private Funcs
    private func hideMetacriticView(_ isHide: Bool) {
        DispatchQueue.main.async { [weak self] in
            self?.metacriticView.isHidden = isHide
        }
    }
    
    private func hideReleasedView(_ isHide: Bool) {
        DispatchQueue.main.async { [weak self] in
            self?.releasedView.isHidden = isHide
        }
    }
    
    private func setBackImageView(_ isDark: Bool) {
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            self.backButtonImageView.image = isDark ? self.arrowImageIsDark
            : self.arrowImageNoDark
        }
    }
    
    private func setLikeImageView(_ isDark: Bool) {
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            self.likeButtonImageView.image = isDark ? self.likeImageIsDark
            : self.likeImageNoDark
        }
    }
    
    @objc private func goBackScreen() {
        dismiss(animated: true)
    }
    
    @objc private func goWeb() {
        //presenter.goWebsite()
    }
    
    private func convertVideoGameToDict() -> [String: Any]? {
        guard let id = videoGame?.id else { return nil }
        let objDict: [String: Any] = [
            "id": id,
            "name": videoGame?.name ?? "",
            "background_image": videoGame?.backgroundImage ?? "",
            "rating": videoGame?.rating ?? 0.0,
            "released": videoGame?.released ?? ""
        ]
        return objDict
    }
    
    @objc private func liked() {
        if !isLiked {
            guard let objDict = convertVideoGameToDict() else { return }
            self.interactor?.likedVideoGame(VideoGameDetailModels.SaveVideoGame.Request(obj: objDict))
        } else {
            let okAction = {
                self.interactor?.unLikedVideoGame()
            }
            self.showPopUp(
                titleOfPopUpForUnLike,
                contentOfPopUpForUnLike,
                buttonTitle: "Remove",
                buttonAction: { okAction() },
                cancelAction: nil)
        }
    }
    
    func hideWebOfGameImageView(_ isHide: Bool) {
        DispatchQueue.main.async { [weak self] in
            self?.webOfGameImageView.isHidden = isHide
        }
    }
    
    func isLikedVideoGame() {
        DispatchQueue.main.async { [weak self] in
            self?.likeButtonImageView.image = self?.likedImage
        }
    }
    
    func setImageView(_ image: String?) {
        guard let image, let url = URL(string: image) else {
            DispatchQueue.main.async { [weak self] in
                guard let self else { return }
                self.gameImageView.image = notFoundImage
                setLikedButton()
                self.setBackImageView(false)
                self.gameImageView.contentMode = .scaleAspectFill
            }
            return
        }
        self.gameImageView.downloadedWithCompletion(from: url) {[weak self] image in
            guard let self else { return }
            guard let image else {
                self.gameImageView.image = notFoundImage
                return
            }
            self.setLikedButton()
            self.setBackImageView(image.isDark(.leftTop))
            self.gameImageView.contentMode = .scaleAspectFill
        }
    }
    
    func setGameName(_ name: String?) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.checkDeviceOrientation(self.landScapeAction, self.portraitAction)
            self.gameNameLabel.text = name
        }
    }
    
    func setReleasedDate(_ date: String?) {
        guard let date else {
            hideReleasedView(true)
            return
        }
        DispatchQueue.main.async { [weak self] in
            self?.realesedDateLabel.text = date
        }
    }
    
    func setMetacriticRate(_ metaCriticRate: Int?) {
        guard let point = metaCriticRate else {
            hideMetacriticView(true)
            return
        }
        DispatchQueue.main.async { [weak self] in
            self?.metacriticRateLabel.text = "\(point)"
        }
    }
    
    private func checkWebOfGame() {
        self.hideWebOfGameImageView(videoGame?.website == "")
    }
    
    private func setLikedButton() {
        if isLiked {
            isLikedVideoGame()
        } else {
            guard let isDark = gameImageView.image?.isDark(.bottomRight) else { return }
            self.setLikeImageView(isDark)
        }
    }
    
    func setDescription(_ description: String?) {
        guard let description else {
            self.descriptionLabel.text = "No description."
            return
        }
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            self.descriptionLabel.attributedText = description.htmlToAttributedString
            self.descriptionLabel.font = self.descriptionLabel.font.withSize(self.descriptionLabelFontSize)
            if self.traitCollection.userInterfaceStyle == .dark {
                self.descriptionLabel.textColor = .white
            }
        }
    }
}

extension VideoGameDetailViewController: VideoGameDetailDisplayLogic {
    func getError(_ content: String) {
        hideLoading()
        self.showAlert("Error", content, nil)
    }
    
    func displayIsLikedVideoGame(isLike: Bool) {
        self.isLiked = isLike
        setLikedButton()
    }
    
    func displayVideoGameList(viewModel: VideoGameDetailModels.FetchVideoGameDetail.ViewModel) {
        self.videoGame = viewModel.results
        self.hideLoading()
        self.setImageView(videoGame?.backgroundImage)
        self.checkWebOfGame()
        self.setDescription(videoGame?.description)
        self.setMetacriticRate(videoGame?.metacritic)
        self.setGameName(videoGame?.name)
        self.setReleasedDate(videoGame?.released)
        self.hideLoading(0.5)
    }
}
// MARK: Extension Configure Funcs
extension VideoGameDetailViewController {
    private func configBackButton() {
        let backTap = UITapGestureRecognizer(target: self, action: #selector(goBackScreen))
        backButtonImageView.addGestureRecognizer(backTap)
    }
    
    private func configureWebOfGameImageView() {
        let goWeb = UITapGestureRecognizer(target: self, action: #selector(goWeb))
        webOfGameImageView.addGestureRecognizer(goWeb)
    }
    
    private func configLikeButton() {
        let likeButton = UITapGestureRecognizer(target: self, action: #selector(liked))
        likeButtonImageView.addGestureRecognizer(likeButton)
    }
}
