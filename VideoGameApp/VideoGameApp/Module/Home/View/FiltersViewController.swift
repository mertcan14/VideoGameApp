//
//  FiltersViewController.swift
//  VideoGameApp
//
//  Created by mertcan YAMAN on 25.07.2023.
//

import UIKit
//checkmark.circle.fill
final class FiltersViewController: BaseViewController {
    @IBOutlet weak var metacriticLowToHighButton: UIButton!
    @IBOutlet weak var metacriticHighToLowButton: UIButton!
    @IBOutlet weak var releasedOlderToNewButton: UIButton!
    @IBOutlet weak var releasedNewToOlderButton: UIButton!
    @IBOutlet weak var ratingLowToHighButton: UIButton!
    @IBOutlet weak var ratingHighToLowButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func sortedButtonClicked(_ sender: Any) {
        guard let button = sender as? UIButton  else { return }
        DispatchQueue.main.async {
            button.tintColor = .fieldColor
        }
    }
}
