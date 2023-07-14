//
//  LoadingShowable.swift
//  VideoGameApp
//
//  Created by mertcan YAMAN on 14.07.2023.
//
protocol LoadingShowable {
    func showLoading()
    func hideLoading()
}

extension LoadingShowable {
    func showLoading() {
        LoadingView.shared.startLoading()
    }

    func hideLoading() {
        LoadingView.shared.hideLoading()
    }
}
