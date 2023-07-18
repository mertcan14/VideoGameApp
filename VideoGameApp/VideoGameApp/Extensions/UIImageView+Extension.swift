//
//  UIImageView+Extension.swift
//  VideoGameApp
//
//  Created by mertcan YAMAN on 17.07.2023.
//

import UIKit

extension UIImageView {
    func downloaded(from url: URL,
                    contentMode mode: ContentMode = .scaleAspectFit
    ) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
            else { return }
            DispatchQueue.main.async { [weak self] in
                self?.image = image
            }
        }.resume()
    }
    
    func downloaded(from link: String, contentMode mode: ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
    
    func downloadedWithCompletion(from url: URL,
                                  contentMode mode: ContentMode = .scaleAspectFit,
                                  completion: @escaping ((_ image: UIImage?) -> Void)
    ) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
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
        downloadedWithCompletion(from: url, contentMode: mode, completion: completion)
    }
}
