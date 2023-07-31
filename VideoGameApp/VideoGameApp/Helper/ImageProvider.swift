//
//  ImageProvider.swift
//  VideoGameApp
//
//  Created by mertcan YAMAN on 31.07.2023.
//

import Foundation
import UIKit

final class ImageProvider {
    static let shared = ImageProvider()
    let cache = NSCache<NSString, UIImage>()
    
    func setImage(image: UIImage, key: NSString) {
        cache.setObject(image, forKey: key)
    }
    
    func getImage(key: NSString) -> UIImage? {
        cache.object(forKey: key)
    }
    
    func refreshCache() {
        cache.removeAllObjects()
    }
}
