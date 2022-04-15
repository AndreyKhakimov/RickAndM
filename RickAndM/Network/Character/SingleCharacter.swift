//
//  Character.swift
//  RickAndM
//
//  Created by Andrey Khakimov on 15.04.2022.
//

import Foundation

class SingleCharacterManager {
    
    private enum Endpoints: EndpointProtocol {
        
        case getSingleCharacter(Int)
        
        var query: String {
            switch self {
            case .getSingleCharacter(let id):
                return "/character/\(id)"
            }
        }
    }
    
    private let networkManager = NetworkManager.shared
    
    func getCharacter(id: Int, completion: @escaping (Result<Character, NetworkError>) -> Void) {
        networkManager.sendRequest(
            endpoint: Endpoints.getSingleCharacter(id),
            completion: { (result: Result<Character, NetworkError>) in
                switch result {
                case .success(let character):
                    completion(.success(character))
                    
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        )
    }
    
}
