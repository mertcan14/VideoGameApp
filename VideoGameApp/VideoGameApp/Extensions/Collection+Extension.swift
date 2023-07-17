//
//  Collection+Extension.swift
//  VideoGameApp
//
//  Created by mertcan YAMAN on 17.07.2023.
//

import Foundation

extension Collection where Indices.Iterator.Element == Index {
    
  subscript (safe index: Index) -> Iterator.Element? {
    return indices.contains(index) ? self[index] : nil
  }
    
}
