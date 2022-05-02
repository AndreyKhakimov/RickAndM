//
//  NetworkManager.swift
//  ContactsList
//
//  Created by Andrey Khakimov on 14.04.2022.
//

import Foundation

class NetworkManager {
    
    static let shared = NetworkManager()
    static let hostUrl = "https://rickandmortyapi.com/api"
    
    private init() {}
    
    @discardableResult
    func sendRequest<Response: Decodable>(endpoint: EndpointProtocol, completion: @escaping (Result<Response, NetworkError>) -> Void) -> URLSessionDataTask {
        var request = URLRequest(url: endpoint.url)
        request.httpMethod = endpoint.httpMethod
        
        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            if let error = error {
                if let rawURLError = error as? URLError,
                   rawURLError.code == URLError.Code.cancelled
                {
                    completion(.failure(.cancelled))
                } else {
                    completion(.failure(.other(error)))
                }
                return
            }
            
            var data = data
            if Response.self == Void.self {
                data = Data()
            }
            guard let data = data
            else {
                completion(.failure(.noData))
                return
            }
            do {
                let result = try JSONDecoder().decode(Response.self, from: data)
                completion(.success(result))
            } catch {
                completion(.failure(.decodingError))
            }
        }
        task.resume()
        return task
    }
    
}


