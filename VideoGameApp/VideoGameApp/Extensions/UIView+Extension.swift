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
