//
//  CoreDataReturnPersistentContainer.swift
//  VideoGameApp
//
//  Created by mertcan YAMAN on 20.07.2023.
//

import Foundation

import UIKit
import CoreData

final class CoreDataReturnPersistentContainer {
    
    static let shared = CoreDataReturnPersistentContainer()
    
    var persistentContainer: NSPersistentContainer?
    
    init() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        self.persistentContainer = appDelegate.persistentContainer
    }
    
}
