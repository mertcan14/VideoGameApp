//
//  UIImage+Extension.swift
//  VideoGameApp
//
//  Created by mertcan YAMAN on 19.07.2023.
//

import UIKit

enum IsDarkArea {
    case all
    case bottomRight
    case leftTop
}

extension UIImage {
    func isDark(_ area: IsDarkArea) -> Bool {
        var red: CGFloat = 0, green: CGFloat = 0, blue: CGFloat = 0
        var alpha: CGFloat = 0
        switch area {
        case .all:
            self.averageColor?.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        case .bottomRight:
            self.averageColorRightBottom?.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        case .leftTop:
            self.averageColorLeftTop?.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        }
        let sumColorValue = red + green + blue
        return sumColorValue < 1.2
    }
}

extension UIImage {
    var averageColor: UIColor? {
        guard let inputImg = CIImage(image: self) else { return nil }
        let extent = inputImg.extent
        let extentVector = CIVector(x: extent.origin.x, y: extent.origin.y, z: extent.size.width, w: extent.size.height)

        return calculateBitmap(inputImg, extentVector)
    }
    
    var averageColorRightBottom: UIColor? {
        guard let inputImg = CIImage(image: self) else { return nil }
        let extent = inputImg.extent
        let pixelSize = extent.size.width * 0.1
        let originX = extent.size.width - pixelSize
        let extentVector = CIVector(x: originX, y: 0, z: pixelSize, w: pixelSize)
        return calculateBitmap(inputImg, extentVector)
    }
    
    var averageColorLeftTop: UIColor? {
        guard let inputImg = CIImage(image: self) else { return nil }
        let extent = inputImg.extent
        let pixelSize = extent.size.height * 0.1
        let originY = extent.size.height - pixelSize
        let extentVector = CIVector(x: 0, y: originY, z: pixelSize, w: pixelSize)

        return calculateBitmap(inputImg, extentVector)
    }
    
    private func calculateBitmap(_ inputImg: CIImage, _ extentVector: CIVector) -> UIColor? {
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
