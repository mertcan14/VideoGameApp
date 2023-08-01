//
//  LoadingView.swift
//  VideoGameApp
//
//  Created by mertcan YAMAN on 14.07.2023.
//

import UIKit

final class LoadingView {
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    static let shared = LoadingView()
    var blurView: UIVisualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .light))
    
    private init() {
        configure()
    }
    
    func configure() {
        blurView.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.hidesWhenStopped = true
        blurView.contentView.addSubview(activityIndicator)
    }
    
    func startLoading() {
        setFrame()
        UIApplication.shared.windows.first?.addSubview(blurView)
        blurView.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.startAnimating()
    }
    
    func hideLoading() {
        DispatchQueue.main.async {
            self.blurView.removeFromSuperview()
            self.activityIndicator.stopAnimating()
        }
    }
    
    private func setFrame() {
        guard let currentWindow = UIApplication.shared.windows.first else { return }
        blurView.frame = currentWindow.frame
        activityIndicator.center = blurView.center
    }
}
