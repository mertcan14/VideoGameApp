//
//  PageDetailViewController.swift
//  VideoGameApp
//
//  Created by mertcan YAMAN on 16.07.2023.
//

import UIKit

final class PageDetailViewController: UIViewController {

    @IBOutlet weak var homeImageView: UIImageView!
    var index = 0
    var image: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let image,
              let imageURL = URL(string: image) else { return }
        homeImageView.downloaded(from: imageURL)
        homeImageView.contentMode = .scaleToFill
    }
    
    static func getInstance(index: Int, image: String?) -> PageDetailViewController {
        guard let vc = UIStoryboard(name: "HomeViewController", bundle: nil)
            .instantiateViewController(withIdentifier: "PageDetailViewController") as? PageDetailViewController else { return PageDetailViewController() }
        vc.index = index
        vc.image = image
        return vc
    }
}
