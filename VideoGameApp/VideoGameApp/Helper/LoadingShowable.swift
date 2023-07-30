//
//  LoadingShowable.swift
//  VideoGameApp
//
//  Created by mertcan YAMAN on 14.07.2023.
//
import Foundation

protocol LoadingShowable {
    func showLoading(_ sleeping: Double?)
    func hideLoading(_ sleeping: Double?)
}

extension LoadingShowable {
    func showLoading(_ sleeping: Double? = 0) {
        if let sleeping {
            DispatchQueue.main.asyncAfter(deadline: .now() + sleeping) {
                LoadingView.shared.startLoading()
            }
        } else {
            LoadingView.shared.startLoading()
        }
    }

    func hideLoading(_ sleeping: Double? = 0) {
        if let sleeping {
            DispatchQueue.main.asyncAfter(deadline: .now() + sleeping) {
                LoadingView.shared.hideLoading()
            }
        } else {
            LoadingView.shared.hideLoading()
        }
    }
}
