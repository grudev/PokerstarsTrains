//
//  NetworkManager.swift
//  Trains
//
//  Created by Dimitar Grudev on 27.02.21.
//

import UIKit

protocol NetworkManager {
    
    static var session: URLSession { get }
    static var decoder: JSONDecoder { get }
    static var encoder: JSONEncoder { get }
    
    func request<T>(_ request: URLRequest,
                    completion: @escaping (Result<T, Error>) -> Void) -> NetworkCancellable where T: Decodable
    
}

protocol NetworkCancellable {
    var taskIdentifier: Int { get }
    func cancel()
}

extension URLSessionTask: NetworkCancellable { }

final class DefaultNetworkManager: NetworkManager {
    
    static var session: URLSession {
        let config = URLSessionConfiguration.default
        config.requestCachePolicy = .reloadIgnoringLocalCacheData
        return URLSession(configuration: config)
    }
    
    static var decoder: JSONDecoder {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }
    
    static var encoder: JSONEncoder {
        let encoder = JSONEncoder()
        return encoder
    }
    
    func request<T>(_ request: URLRequest, completion: @escaping (Result<T, Error>) -> Void) -> NetworkCancellable where T: Decodable {
        let dataTask = DefaultNetworkManager.session.dataTask(with: request) { data, response, error in
            
            // NOTE: - Make sure to return the callback on main thread
            DispatchQueue.main.async {
                if let error = error {
                    completion(.failure(error))
                } else {
                    guard let data = data else {
                        print("No Response")
                        return
                    }
                    do {
                        let decodedData = try DefaultNetworkManager.decoder.decode(T.self, from: data)
                        completion(.success(decodedData))
                    } catch {
                        completion(.failure(error))
                    }
                }
            }
            
        }
        dataTask.resume()
        return dataTask
    }
    
}
