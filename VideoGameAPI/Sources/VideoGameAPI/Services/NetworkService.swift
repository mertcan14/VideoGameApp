//
//  NetworkService.swift
//  
//
//  Created by mertcan YAMAN on 13.07.2023.
//

import Foundation

public protocol NetworkServiceProtocol: AnyObject {
    func fetchFromAPI<T: BaseRequestProtocol>(_ request: T, completion: @escaping (Result<T.Response, Error>) -> Void)
}

public class NetworkService: NetworkServiceProtocol {
    public func fetchFromAPI<T>(_ request: T, completion: @escaping (Result<T.Response, Error>) -> Void) where T : BaseRequestProtocol {
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
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.method.rawValue
        urlRequest.allHTTPHeaderFields = request.headers
        
        URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            if let error = error {
                return completion(.failure(error))
            }
            
            guard let response = response as? HTTPURLResponse, 200..<300 ~= response.statusCode else {
                return completion(.failure(NSError()))
            }
            
            guard let data = data else {
                return completion(.failure(NSError()))
            }
            
            do {
                try completion(.success(request.decode(data)))
            } catch let error as NSError {
                completion(.failure(error))
            }
        }.resume()
    }
}
