//
//  VideoGameCollectionViewCell.swift
//  VideoGameApp
//
//  Created by mertcan YAMAN on 17.07.2023.
//

import UIKit

// MARK: - Class VideoGameCollectionViewCell
final class VideoGameCollectionViewCell: UICollectionViewCell {
    // MARK: - IBOutlet Definitions
    @IBOutlet weak var outerView: UIView!
    @IBOutlet weak var imageOfGameView: UIImageView!
    @IBOutlet weak var relesedOfGameLabel: UILabel!
    @IBOutlet weak var ratingOfGameLabel: UILabel!
    @IBOutlet weak var ratingView: UIStackView!
    @IBOutlet weak var nameOfGameLabel: UILabel!
    @IBOutlet weak var realesedView: UIStackView!
    // MARK: - Variable Definitions
    private let loadingImage: UIImage = .loading
    private let borderColor: UIColor = .cellBorderColor
    private let borderWidth: CGFloat = 1.0
    private let defaultNameOfGame: String = "No Name"
    internal var videoGame: VideoGameNetworkModel? {
        didSet {
            load()
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.imageOfGameView.image = nil
        self.relesedOfGameLabel.text = nil
        self.ratingOfGameLabel.text = nil
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setBorder()
    }
    
    private func setBorder() {
        outerView.layer.borderWidth = borderWidth
        outerView.layer.borderColor = borderColor.cgColor
    }
    
    func load() {
        guard let videoGame else { return }
        self.setImage(videoGame.backgroundImage)
        self.setNameOfGame(videoGame.name)
        self.setRatingOfGame(videoGame.rating)
        self.setReleasedOfGame(videoGame.released)
    }
}
// MARK: - Extension VideoGameCollectionViewCellProtocol
extension VideoGameCollectionViewCell {
    func setImage(_ image: String?) {
        guard let image else {
            self.imageOfGameView.image = .noimage
            return
        }
        DispatchQueue.main.async { [weak self] in
            self?.imageOfGameView.downloaded(from: image, contentMode: .scaleAspectFit)
            self?.imageOfGameView.contentMode = .scaleAspectFill
        }
    }
    
    func setNameOfGame(_ text: String?) {
        guard let text else {
            self.nameOfGameLabel.text = defaultNameOfGame
            return
        }
        DispatchQueue.main.async { [weak self] in
            self?.nameOfGameLabel.text = text
        }
    }
    
    func setRatingOfGame(_ text: Double?) {
        guard let text else {
            self.ratingView.isHidden = true
            return
        }
        if text == 0.0 {
            self.ratingView.isHidden = true
            return
        }
        DispatchQueue.main.async { [weak self] in
            self?.ratingView.isHidden = false
            self?.ratingOfGameLabel.text = "\(text)"
        }
    }
    
    func setReleasedOfGame(_ text: String?) {
        guard let text else {
            self.realesedView.isHidden = true
            return
        }
        DispatchQueue.main.async { [weak self] in
            self?.realesedView.isHidden = false
            self?.relesedOfGameLabel.text = text
        }
    }
}
