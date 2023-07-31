//
//  UIImageView+Extension.swift
//  VideoGameApp
//
//  Created by mertcan YAMAN on 17.07.2023.
//

import UIKit

extension UIImageView {
    func downloaded(from url: URL) {
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
            else { return }
            DispatchQueue.main.async { [weak self] in
                self?.image = image
                ImageProvider.shared.setImage(image: image, key: url.absoluteString as NSString)
            }
        }.resume()
    }
    
    func downloaded(from link: String, contentMode mode: ContentMode = .scaleAspectFit) {
        if let image = ImageProvider.shared.getImage(key: link as NSString) {
            self.image = image
        }
        
        guard let url = URL(string: link) else { return }
        downloaded(from: url)
    }
    
    func downloadedWithCompletion(from url: URL,
                                  completion: @escaping ((_ image: UIImage?) -> Void)
    ) {
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
            else { return }
            DispatchQueue.main.async { [weak self] in
                self?.image = image
                completion(image)
            }
        }.resume()
    }
    
    func downloadedWithCompletion(from link: String,
                                  contentMode mode: ContentMode = .scaleAspectFit,
                                  completion: @escaping ((_ image: UIImage?) -> Void)
    ) {
        guard let url = URL(string: link) else { return }
        downloadedWithCompletion(from: url, completion: completion)
    }
}
