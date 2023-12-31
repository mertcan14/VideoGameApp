//
//  UIView+Extension.swift
//  VideoGameApp
//
//  Created by mertcan YAMAN on 14.07.2023.
//

import UIKit

extension UIView {
    @IBInspectable var cornerRadius: CGFloat {
        get { return self.cornerRadius }
        set { self.layer.cornerRadius = newValue }
    }
}

extension UIView {
    // swiftlint:disable legacy_constructor
    func addTopBorderWithColor(color: UIColor, width: CGFloat) {
        let border = CALayer()
        border.name = "border"
        border.backgroundColor = color.cgColor
        border.frame = CGRectMake(0, 0, self.frame.size.width, width)
        self.layer.addSublayer(border)
    }
    
    func addRightBorderWithColor(color: UIColor, width: CGFloat) {
        let border = CALayer()
        border.name = "border"
        border.backgroundColor = color.cgColor
        border.frame = CGRectMake(self.frame.size.width - width, 0, width, self.frame.size.height)
        self.layer.addSublayer(border)
    }
    
    func addBottomBorderWithColor(color: UIColor, width: CGFloat) {
        let border = CALayer()
        border.name = "border"
        border.backgroundColor = color.cgColor
        border.frame = CGRectMake(0, self.frame.size.height - width, self.frame.width, width)
        self.layer.addSublayer(border)
    }
    
    func addLeftBorderWithColor(color: UIColor, width: CGFloat) {
        let border = CALayer()
        border.name = "border"
        border.backgroundColor = color.cgColor
        border.frame = CGRectMake(0, 0, width, self.frame.size.height)
        self.layer.addSublayer(border)
    }
    
    func deleteSublayer() {
        guard let sublayers = self.layer.sublayers else { return }

        for sublayer in sublayers where sublayer.isKind(of: CALayer.self) {
            if sublayer.name == "border" {
                sublayer.removeFromSuperlayer()
            }
        }
    }
    
    func updateBottomBorderWithColor(color: UIColor, width: CGFloat) {
        self.deleteSublayer()
        self.addBottomBorderWithColor(color: color, width: width)
    }
    // swiftlint:enable legacy_constructor
}
