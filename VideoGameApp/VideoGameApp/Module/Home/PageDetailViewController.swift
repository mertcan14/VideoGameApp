//
//  PageDetailViewController.swift
//  VideoGameApp
//
//  Created by mertcan YAMAN on 16.07.2023.
//

import UIKit

final class PageDetailViewController: UIViewController {

    // MARK: - IBOutlet Definitions
    @IBOutlet weak var homeImageView: UIImageView!
    
    // MARK: - Variable Definitions
    private var index = 0
    private var image: String?

    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let image,
              let imageURL = URL(string: image) else { return }
        homeImageView.downloaded(from: imageURL)
        homeImageView.contentMode = .scaleToFill
    }
    
    // MARK: - Funcs
    static func getInstance(index: Int, image: String?) -> PageDetailViewController {
        let storyboard = UIStoryboard(name: "HomeViewController", bundle: nil)
        guard let vc = storyboard.instantiateViewController(withIdentifier: "PageDetailViewController")
                as? PageDetailViewController else { return PageDetailViewController() }
        vc.index = index
        vc.image = image
        return vc
    }
}
