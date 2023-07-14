//
//  NetworkError.swift
//  
//
//  Created by mertcan YAMAN on 13.07.2023.
//

import Foundation

public enum NetworkError: Error {
    
    case emptyDataError
    case operationFailed
    case connectionError
    case invalidChar
    case notFoundPageError
    case error(Error)
    
    public var message: String? {
        switch self {
        case .operationFailed:
            return "We encountered an unexpected error"
        case .connectionError:
            return "You do not have an internet connection"
        case .error(let error):
            return error.localizedDescription
        case .emptyDataError:
            return "We couldn't find the result you were looking for"
        case .invalidChar:
            return "You entered an invalid character"
        case .notFoundPageError:
            return "The API you are looking for was not found. Url is wrong"
        }
    }
}
