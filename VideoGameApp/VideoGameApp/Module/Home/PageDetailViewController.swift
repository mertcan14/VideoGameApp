//
//  PageDetailViewController.swift
//  VideoGameApp
//
//  Created by mertcan YAMAN on 16.07.2023.
//

import UIKit

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

final class PageDetailViewController: UIViewController {

    // MARK: - IBOutlet Definitions
    @IBOutlet weak var platformStackView: UIStackView!
    @IBOutlet weak var blurView: UIVisualEffectView!
    @IBOutlet weak var nameOfGameLbl: UILabel!
    @IBOutlet weak var homeImageView: UIImageView!
    @IBOutlet weak var platformSWWidth: NSLayoutConstraint!
    
    // MARK: - Variable Definitions
    private var index = 0
    private var videoGame: VideoGame?

    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        configBlurView()
        setup()
    }
    
    // MARK: - Funcs
    private func configBlurView() {
        blurView.layer.cornerRadius = 24
        blurView.clipsToBounds = true
        blurView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
    }
    
    private func createImageView(_ nameOfPlatform: String, _ isDark: Bool) -> UIImageView {
        let imageView = UIImageView(
            image: isDark ? ParentPlatformEnum(rawValue: nameOfPlatform)?.imageWhite
            : ParentPlatformEnum(rawValue: nameOfPlatform)?.imageDark)
        imageView.contentMode = .scaleAspectFit
        return imageView
    }
    
    private func setup() {
        guard let videoGame,
              let image = videoGame.backgroundImage,
              let imageURL = URL(string: image) else { return }
        nameOfGameLbl.text = videoGame.name
        homeImageView.downloadedWithCompletion(from: imageURL) {[weak self] image in
            var red: CGFloat = 0
            var green: CGFloat = 0
            var blue: CGFloat = 0
            var alpha: CGFloat = 0
            image?.averageColor?.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
            let sumColorValue = red + green + blue
            self?.setPlatform(sumColorValue < 1)
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
    
    static func getInstance(index: Int, videoGame: VideoGame?) -> PageDetailViewController {
        let storyboard = UIStoryboard(name: "HomeViewController", bundle: nil)
        guard let vc = storyboard.instantiateViewController(withIdentifier: "PageDetailViewController")
                as? PageDetailViewController else { return PageDetailViewController() }
        vc.index = index
        vc.videoGame = videoGame
        return vc
    }
}

extension UIImage {
    var averageColor: UIColor? {
        guard let inputImage = CIImage(image: self) else { return nil }
        let extentVector = CIVector(x: inputImage.extent.origin.x, y: inputImage.extent.origin.y, z: inputImage.extent.size.width, w: inputImage.extent.size.height)

        guard let filter = CIFilter(name: "CIAreaAverage", parameters: [kCIInputImageKey: inputImage, kCIInputExtentKey: extentVector]) else { return nil }
        guard let outputImage = filter.outputImage else { return nil }

        var bitmap = [UInt8](repeating: 0, count: 4)
        let context = CIContext(options: [.workingColorSpace: kCFNull])
        context.render(outputImage, toBitmap: &bitmap, rowBytes: 4, bounds: CGRect(x: 0, y: 0, width: 1, height: 1), format: .RGBA8, colorSpace: nil)

        return UIColor(red: CGFloat(bitmap[0]) / 255, green: CGFloat(bitmap[1]) / 255, blue: CGFloat(bitmap[2]) / 255, alpha: CGFloat(bitmap[3]) / 255)
    }
}
