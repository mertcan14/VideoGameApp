//
//  VideoGameCollectionViewCell.swift
//  VideoGameApp
//
//  Created by mertcan YAMAN on 17.07.2023.
//

import UIKit

protocol VideoGameCollectionViewCellProtocol: AnyObject {
    func setImage(_ image: URL)
    func setNameOfGame(_ text: String)
    func setRatingOfGame(_ text: Double)
    func setReleasedOfGame(_ text: String)
}

final class VideoGameCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var outerView: UIView!
    @IBOutlet weak var imageOfGameView: UIImageView!
    @IBOutlet weak var relesedOfGameLabel: UILabel!
    @IBOutlet weak var ratingOfGameLabel: UILabel!
    @IBOutlet weak var nameOfGameLabel: UILabel!
    
    var cellPresenter: VideoGameCellPresenterProtocol! {
        didSet {
            cellPresenter.load()
        }
    }
    
    override func awakeFromNib() {
            super.awakeFromNib()

           setShadow()
        }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        // TODO: Reset
    }
    
    private func setShadow() {
        outerView.layer.shadowColor = UIColor.black.cgColor
        outerView.layer.shadowOpacity = 0.8
        outerView.layer.shadowOffset = .zero
        outerView.layer.shadowRadius = 1.5
    }
}

extension VideoGameCollectionViewCell: VideoGameCollectionViewCellProtocol {
    func setImage(_ image: URL) {
        self.imageOfGameView.downloaded(from: image)
    }
    
    func setNameOfGame(_ text: String) {
        self.nameOfGameLabel.text = text
    }
    
    func setRatingOfGame(_ text: Double) {
        self.ratingOfGameLabel.text = "\(text)"
    }
    
    func setReleasedOfGame(_ text: String) {
        self.relesedOfGameLabel.text = text
    }
}
