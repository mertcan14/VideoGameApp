//
//  NetworkService.swift
//  
//
//  Created by mertcan YAMAN on 13.07.2023.
//

import Foundation

public protocol NetworkServiceProtocol: AnyObject {
    func fetchFromAPI<T: BaseRequestProtocol>(_ request: T, completion: @escaping (Result<T.Response, NetworkError>) -> Void)
}

public class NetworkService: NetworkServiceProtocol {
    public static let shared = NetworkService()
    
    public func fetchFromAPI<T>(_ request: T, completion: @escaping (Result<T.Response, NetworkError>) -> Void) where T : BaseRequestProtocol {
        var urlRequest: URLRequest
        
        if let urlConst = request.urlConst, let url = URL(string: urlConst) {
            urlRequest = URLRequest(url: url)
            urlRequest.httpMethod = request.method.rawValue
            urlRequest.allHTTPHeaderFields = request.headers
        } else {
            guard var urlComponent = URLComponents(string: request.url) else {
                return completion(.failure(NetworkError.notFoundPageError))
            }
            
            var queryItems: [URLQueryItem] = []
            request.queryItems.forEach { key,value in
                let urlQueryItem = URLQueryItem(name: key, value: value)
                urlComponent.queryItems?.append(urlQueryItem)
                queryItems.append(urlQueryItem)
            }
            urlComponent.queryItems = queryItems
            
            guard let url = urlComponent.url else {
                return completion(.failure(NetworkError.notFoundPageError))
            }
            urlRequest = URLRequest(url: url)
            urlRequest.httpMethod = request.method.rawValue
            urlRequest.allHTTPHeaderFields = request.headers
        }
        URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            if error != nil {
                return completion(.failure(NetworkError.operationFailed))
            }
            
            guard let response = response as? HTTPURLResponse, 200..<300 ~= response.statusCode else {
                return completion(.failure(NetworkError.operationFailed))
            }
            
            guard let data = data else {
                return completion(.failure(NetworkError.operationFailed))
            }
            
            do {
                try completion(.success(request.decode(data)))
            } catch {
                completion(.failure(NetworkError.operationFailed))
            }
        }.resume()
    }
}
