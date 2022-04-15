//
//  CharactersNetworkManager.swift
//  ContactsList
//
//  Created by Andrey Khakimov on 14.04.2022.
//

import UIKit

class CharactersNetworkManager {
    
    private enum Endpoints: EndpointProtocol {
        
        case getCharactersByPage(Int)
        
        var query: String {
            switch self {
            case .getCharactersByPage(let pageNumber):
                return "/?page=\(pageNumber)"
            }
        }
    }
    
    private let networkManager = NetworkManager.shared
    
    func getSuggestedContacts(number: Int, completion: @escaping (Result<[Character], NetworkError>) -> Void) {
        networkManager.sendRequest(
            endpoint: Endpoints.getCharactersByPage(number),
            completion: { (result: Result<CharactersResponse, NetworkError>) in
                switch result {
                case .success(let characters):
                    completion(.success(characters.results))
                    
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        )
    }
    
}
