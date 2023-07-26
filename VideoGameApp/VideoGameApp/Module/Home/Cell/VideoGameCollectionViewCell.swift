//
//  VideoGameCollectionViewCell.swift
//  VideoGameApp
//
//  Created by mertcan YAMAN on 17.07.2023.
//

import UIKit
private let loadingImage: UIImage = .loading
private let borderColor: UIColor = .cellBorderColor
private let borderWidth: CGFloat = 1.0
private let defaultNameOfGame: String = "No Name"
// MARK: - Protocol VideoGameCollectionViewCellProtocol
protocol VideoGameCollectionViewCellProtocol: AnyObject {
    func setImage(_ image: URL?)
    func setNameOfGame(_ text: String?)
    func setRatingOfGame(_ text: Double?)
    func setReleasedOfGame(_ text: String?)
}
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
    
    var cellPresenter: VideoGameCellPresenterProtocol! {
        didSet {
            cellPresenter.load()
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.imageOfGameView.image = loadingImage
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
}
// MARK: - Extension VideoGameCollectionViewCellProtocol
extension VideoGameCollectionViewCell: VideoGameCollectionViewCellProtocol {
    func setImage(_ image: URL?) {
        guard let image else {
            self.imageOfGameView.image = .noimage
            return
        }
        self.imageOfGameView.downloaded(from: image)
        self.imageOfGameView.contentMode = .scaleAspectFill
    }
    
    func setNameOfGame(_ text: String?) {
        guard let text else {
            self.nameOfGameLabel.text = defaultNameOfGame
            return
        }
        self.nameOfGameLabel.text = text
    }
    
    func setRatingOfGame(_ text: Double?) {
        guard let text else {
            self.ratingView.isHidden = true
            return
        }
        self.ratingOfGameLabel.text = "\(text)"
    }
    
    func setReleasedOfGame(_ text: String?) {
        guard let text else {
            self.realesedView.isHidden = true
            return
        }
        self.relesedOfGameLabel.text = text
    }
}
