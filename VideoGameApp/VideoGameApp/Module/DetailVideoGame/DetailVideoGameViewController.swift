//
//  DetailVideoGameViewController.swift
//  VideoGameApp
//
//  Created by mertcan YAMAN on 19.07.2023.
//

import UIKit
// MARK: - Protocol DetailVideoGameViewControllerProtocol
protocol DetailVideoGameViewControllerProtocol: BaseViewControllerProtocol {
    func setImageView(_ url: URL)
    func setGameName(_ name: String)
    func setRealesedDate(_ date: String)
    func setMetacriticRate(_ metaCriticRate: String)
    func setDescription(_ description: String)
}
// MARK: - Class DetailVideoGameViewController
final class DetailVideoGameViewController: BaseViewController {
    @IBOutlet weak var backButtonImageView: UIImageView!
    @IBOutlet weak var likeButtonImageView: UIImageView!
    @IBOutlet weak var realesedDateLabel: UILabel!
    @IBOutlet weak var metacriticRateLabel: UILabel!
    @IBOutlet weak var gameNameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var gameImageView: UIImageView!
    
    var presenter: DetailVideoGamePresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showLoading()
        presenter.viewDidLoad()
        configBackButton()
    }
    @IBAction func goBackBtnClicked(_ sender: Any) {
        presenter.goBackScreen()
    }
    
    private func configBackButton() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(goBackScreen))
        backButtonImageView.addGestureRecognizer(tap)
    }
    
    private func setBackImageView(_ isDark: Bool) {
        DispatchQueue.main.async { [weak self] in
            self?.backButtonImageView.image = isDark ? .arrowW : .arrow
            
        }
    }
    
    private func setLikeImageView(_ isDark: Bool) {
        DispatchQueue.main.async { [weak self] in
            self?.likeButtonImageView.image = isDark ? .likeiconW : .likeicon
        }
    }
    
    @objc private func goBackScreen() {
        presenter.goBackScreen()
    }
}
// MARK: - Extension DetailVideoGameViewControllerProtocol
extension DetailVideoGameViewController: DetailVideoGameViewControllerProtocol {
    func setImageView(_ url: URL) {
        self.gameImageView.downloadedWithCompletion(from: url) {[weak self] image in
            guard let image else {
                self?.gameImageView.image = .noimage
                return
            }
            self?.setLikeImageView(image.isDarkBottomRight())
            self?.setBackImageView(image.isDarkLeftTop())
            self?.gameImageView.contentMode = .scaleAspectFill
        }
    }
    
    func setGameName(_ name: String) {
        DispatchQueue.main.async { [weak self] in
            self?.gameNameLabel.text = name
        }
    }
    
    func setRealesedDate(_ date: String) {
        DispatchQueue.main.async { [weak self] in
            self?.realesedDateLabel.text = date
        }
    }
    
    func setMetacriticRate(_ metaCriticRate: String) {
        DispatchQueue.main.async { [weak self] in
            self?.metacriticRateLabel.text = metaCriticRate
        }
    }
    
    func setDescription(_ description: String) {
        DispatchQueue.main.async { [weak self] in
            self?.descriptionLabel.attributedText = description.htmlToAttributedString
            self?.descriptionLabel.font = self?.descriptionLabel.font.withSize(16)
        }
    }
}
extension String {
    var htmlToAttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else { return nil }
        do {
            return try NSAttributedString(data: data,
                                          options: [.documentType: NSAttributedString.DocumentType.html,
                                                    .characterEncoding: String.Encoding.utf8.rawValue],
                                          documentAttributes: nil)
        } catch {
            return nil
        }
    }
    var htmlToString: String {
        return htmlToAttributedString?.string ?? ""
    }
}
