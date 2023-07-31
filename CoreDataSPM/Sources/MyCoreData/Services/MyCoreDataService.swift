//
//  MyCoreDataService.swift
//  
//
//  Created by mertcan YAMAN on 20.07.2023.
//

import Foundation
import CoreData

public enum CoreDataError: Error {
    case operationFailed
    case emptyValue
    case objAvailable
    case error(Error)
    
    public var message: String? {
        switch self {
        case .operationFailed:
            return "We encountered an unexpected error"
        case .emptyValue:
            return "Searched data not found"
        case .error(let error):
            return error.localizedDescription
        case .objAvailable:
            return "Object pre-added. Data can't be repeated"
        }
    }
}

public final class MyCoreDataService {
    public static let shared = MyCoreDataService()
    
    public func fetchData<T: Decodable>(_ persistentContainer: NSPersistentContainer,
                                              entityName: String,
                                              completion: @escaping (Result<T, CoreDataError>) -> Void)
    {
        let context = persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        do {
            let results = try context.fetch(fetchRequest)
            if results.count > 0 {
                guard let resultsNS = results as? [NSManagedObject] else  {
                    completion(.failure(.operationFailed))
                    return
                }
                let jsonData = try JSONSerialization.data(withJSONObject:convertToJSONArray(moArray: resultsNS))
                let response = try JSONDecoder().decode(T.self, from: jsonData)
                completion(.success(response))
            } else {
                completion(.failure(.emptyValue))
            }
        } catch {
            completion(.failure(.operationFailed))
        }
    }
    
    public func addObj( persistentContainer: NSPersistentContainer,
                        entityName: String,
                        addObj: [String: Any],
                        checkObjectFromAddObjKey: String? = nil,
                        checkObjectAttribute: [String: Any]? = nil,
                        completion: @escaping (Result<Bool, CoreDataError>) -> Void) {
        let context = persistentContainer.viewContext
        context.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        if let checkObjectKey = checkObjectFromAddObjKey {
            checkObject(persistentContainer,
                        entityName: entityName,
                        checkAttribute: [checkObjectKey: addObj[checkObjectKey]]) { response in
                switch response {
                case .success(let data):
                    if data {
                        completion(.failure(.objAvailable))
                    }
                case .failure(_):
                    completion(.failure(.operationFailed))
                }
            }
        }
        
        if let checkObjectKey = checkObjectAttribute {
            checkObject(persistentContainer,
                        entityName: entityName,
                        checkAttribute: checkObjectKey) { response in
                switch response {
                case .success(let data):
                    if data {
                        completion(.failure(.objAvailable))
                    }
                case .failure(_):
                    completion(.failure(.operationFailed))
                }
            }
        }
        
        let wordHistory = NSEntityDescription.insertNewObject(forEntityName: entityName, into: context)
        addObj.keys.forEach { key in
            wordHistory.setValue(addObj[key], forKey: key)
        }
        do {
            try context.save()
            completion(.success(true))
        }catch {
            completion(.failure(.operationFailed))
        }
    }
    
    public func checkObject(_ persistentContainer: NSPersistentContainer,
                            entityName: String,
                            checkAttribute: [String:Any],
                            completion: @escaping (Result<Bool, CoreDataError>) -> Void) {
        let context = persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        var keys: [String:NSPredicate] = [:]
        
        for key in checkAttribute.keys {
            keys[key] = NSPredicate(format: "\(key) = %@", "\(checkAttribute[key] ?? "")")
        }
        
        let predicate = NSCompoundPredicate(andPredicateWithSubpredicates: keys.values.map({ predicate in
            return predicate
        }))
        
        fetchRequest.predicate = predicate
        do {
            let results = try context.fetch(fetchRequest)
            if results.count > 0 {
                completion(.success(true))
            }else {
                completion(.success(false))
            }
        }catch {
            completion(.failure(.operationFailed))
        }
    }
    
    public func deleteObj(
        _ persistentContainer: NSPersistentContainer,
        entityName: String,
        _ removeObj: [String:Any],
        completion: @escaping (Result<Bool, CoreDataError>) -> Void
    ) {
        let context = persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        var keys: [String:NSPredicate] = [:]
        
        for key in removeObj.keys {
            keys[key] = NSPredicate(format: "\(key) = %@", "\(removeObj[key] ?? "")")
        }
        
        let predicate = NSCompoundPredicate(andPredicateWithSubpredicates: keys.values.map({ predicate in
            return predicate
        }))
        
        fetchRequest.predicate = predicate
        do {
            let results = try context.fetch(fetchRequest)
            guard let result = results.first as? NSManagedObject else {
                completion(.success(false))
                return
            }
            context.delete(result)
            try context.save()
            completion(.success(true))
        }catch {
            completion(.failure(.operationFailed))
        }
    }
    
    private func convertToJSONArray(moArray: [NSManagedObject]) -> [[String: Any]] {
        var jsonArray: [[String: Any]] = []
        for item in moArray {
            var dict: [String: Any] = [:]
            for attribute in item.entity.attributesByName {
                //check if value is present, then add key to dictionary so as to avoid the nil value crash
                if let value = item.value(forKey: attribute.key) {
                    dict[attribute.key] = value
                }
            }
            jsonArray.append(dict)
        }
        return jsonArray
    }
}
