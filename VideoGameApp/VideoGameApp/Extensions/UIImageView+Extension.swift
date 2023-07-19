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

extension UIImage {
    var averageColor: UIColor? {
        guard let inputImg = CIImage(image: self) else { return nil }
        let extent = inputImg.extent
        let extentVector = CIVector(x: extent.origin.x, y: extent.origin.y, z: extent.size.width, w: extent.size.height)

        guard let filter = CIFilter(
            name: "CIAreaAverage",
            parameters: [kCIInputImageKey: inputImg, kCIInputExtentKey: extentVector]) else { return nil }
        guard let outputImage = filter.outputImage else { return nil }

        var bitmap = [UInt8](repeating: 0, count: 4)
        let context = CIContext(options: [.workingColorSpace: kCFNull])
        context.render(outputImage, toBitmap: &bitmap, rowBytes: 4, bounds: CGRect(x: 0, y: 0, width: 1, height: 1), format: .RGBA8, colorSpace: nil)

        return UIColor(
            red: CGFloat(bitmap[0]) / 255,
            green: CGFloat(bitmap[1]) / 255,
            blue: CGFloat(bitmap[2]) / 255,
            alpha: CGFloat(bitmap[3]) / 255)
    }
}
