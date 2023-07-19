//
//  PageDetailViewController.swift
//  VideoGameApp
//
//  Created by mertcan YAMAN on 16.07.2023.
//

import UIKit

private let imageCornerRadius: CGFloat = 24
private let blurViewCorner: CACornerMask = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]

// MARK: - Enum ParentPlatformEnum
enum ParentPlatformEnum: String {
    case pc = "PC"
    case apple = "Apple Macintosh"
    case linux = "Linux"
    case nintendo = "Nintendo"
    case ps = "PlayStation"
    case xbox = "Xbox"
    case android = "Android"
    
    var imageDark: UIImage {
        switch self {
        case .pc:
            return .computer
        case .apple:
            return .apple
        case .linux:
            return .linux
        case .nintendo:
            return .nintendo
        case .ps:
            return .playstation
        case .xbox:
            return .xbox
        case .android:
            return .android
        }
    }
    
    var imageWhite: UIImage {
        switch self {
        case .pc:
            return .computerW
        case .apple:
            return .appleW
        case .linux:
            return .linuxW
        case .nintendo:
            return .nintendoW
        case .ps:
            return .playstationW
        case .xbox:
            return .xboxW
        case .android:
            return .androidW
        }
    }
}
// MARK: - Class PageDetailViewController
final class PageDetailViewController: UIViewController {

    // MARK: - IBOutlet Definitions
    @IBOutlet weak var platformStackView: UIStackView!
    @IBOutlet weak var blurView: UIVisualEffectView!
    @IBOutlet weak var nameOfGameLbl: UILabel!
    @IBOutlet weak var homeImageView: UIImageView!
    @IBOutlet weak var platformSWWidth: NSLayoutConstraint!
    
    // MARK: - Variable Definitions
    private var videoGame: VideoGame?

    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        configBlurView()
        setup()
        configImageView()
    }
    
    // MARK: - Funcs For Configure
    private func configBlurView() {
        blurView.layer.cornerRadius = imageCornerRadius
        blurView.clipsToBounds = true
        blurView.layer.maskedCorners = blurViewCorner
    }
    
    private func configImageView() {
        homeImageView.layer.cornerRadius = imageCornerRadius
        homeImageView.clipsToBounds = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        homeImageView.addGestureRecognizer(tap)
    }
    
    private func createImageView(_ nameOfPlatform: String, _ isDark: Bool) -> UIImageView {
        let imageView = UIImageView(
            image: isDark ? ParentPlatformEnum(rawValue: nameOfPlatform)?.imageWhite
            : ParentPlatformEnum(rawValue: nameOfPlatform)?.imageDark)
        imageView.contentMode = .scaleAspectFit
        return imageView
    }
    
    private func setup() {
        guard let videoGame else { return }
        nameOfGameLbl.text = videoGame.name
        guard let image = videoGame.backgroundImage,
              let imageURL = URL(string: image) else { return }
        homeImageView.downloadedWithCompletion(from: imageURL) {[weak self] image in
            guard let image else { return }
            self?.setPlatform(image.isDark())
            self?.homeImageView.contentMode = .scaleToFill
        }
        homeImageView.contentMode = .scaleToFill
        
    }
    
    private func setPlatform(_ isDark: Bool) {
        guard let videoGame,
              let platforms = videoGame.parentPlatforms else { return }
        platformSWWidth.constant = 0
        platforms.forEach { [weak self] platform in
            guard let platform = platform.platform,
                  let nameOfPlatform = platform.name else { return }
            guard let imageView = self?.createImageView(nameOfPlatform, isDark) else { return }
            self?.platformStackView.addArrangedSubview(imageView)
            self?.platformSWWidth.constant += 25
        }
    }
    // MARK: Funcs
    @objc func handleTap() {
        let sendVC = DetailVideoGameRouter.createModule()
        self.navigationController?.pushViewController(sendVC, animated: true)
        guard let idOfVideoGame = videoGame?.id else { return }
        sendVC.presenter.setIdOfVideoGame(String(idOfVideoGame))
    }
    // MARK: - Funcs For Instance
    static func getInstance(videoGame: VideoGame?) -> PageDetailViewController {
        let storyboard = UIStoryboard(name: "HomeViewController", bundle: nil)
        guard let vc = storyboard.instantiateViewController(withIdentifier: "PageDetailViewController")
                as? PageDetailViewController else { return PageDetailViewController() }
        vc.videoGame = videoGame
        return vc
    }
}
