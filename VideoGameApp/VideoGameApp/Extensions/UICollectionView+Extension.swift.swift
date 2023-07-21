//
//  UICollectionView+Extension.swift
//  VideoGameApp
//
//  Created by mertcan YAMAN on 20.07.2023.
//

import UIKit

extension UICollectionView {
    func setEmptyView(title: String, message: String) {
        let emptyView = UIView(frame: CGRect(x: self.center.x,
                                             y: self.center.y,
                                             width: self.bounds.size.width,
                                             height: self.bounds.size.height))
        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.textColor = .black
        titleLabel.font = .systemFont(ofSize: 18, weight: .bold)
        titleLabel.text = title
        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = .center
        
        let messageLabel = UILabel()
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.textColor = .black
        messageLabel.font = .systemFont(ofSize: 17, weight: .medium)
        messageLabel.text = message
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        
        emptyView.addSubview(titleLabel)
        emptyView.addSubview(messageLabel)
        NSLayoutConstraint.activate([
            titleLabel.centerYAnchor.constraint(equalTo: emptyView.centerYAnchor),
            titleLabel.centerXAnchor.constraint(equalTo: emptyView.centerXAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: emptyView.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: emptyView.trailingAnchor, constant: -20),
            messageLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            messageLabel.leadingAnchor.constraint(equalTo: emptyView.leadingAnchor, constant: 20),
            messageLabel.trailingAnchor.constraint(equalTo: emptyView.trailingAnchor, constant: -20)
        ])
        self.backgroundView = emptyView
    }
    
    func restore() {
        self.backgroundView = nil
    }
}

public extension UICollectionView {
    func register<T: UICollectionViewCell>(cellType: T.Type, bundle: Bundle? = nil) {
        guard let className = NSStringFromClass(cellType).split(separator: ".").last else { return }
        let nib = UINib(nibName: String(className), bundle: bundle)
        register(nib, forCellWithReuseIdentifier: String(className))
    }
    
    func register<T: UICollectionViewCell>(cellTypes: [T.Type], bundle: Bundle? = nil) {
        cellTypes.forEach { register(cellType: $0, bundle: bundle) }
    }
    
    func dequeueReusableCell<T: UICollectionViewCell>(indexPath: NSIndexPath, cellType: T.Type) -> T {
        guard let className = NSStringFromClass(cellType).split(separator: ".").last else { return UICollectionViewCell() as! T }
        guard let cell = dequeueReusableCell(withReuseIdentifier: String(className), for: indexPath as IndexPath) as? T else {
            fatalError("Could not dequeue cell with identifier: \(String(className))")
        }
        return cell
    }
}
