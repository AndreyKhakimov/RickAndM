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
        case getSingleCharacter(Int)
        
        var query: String {
            switch self {
            case .getCharactersByPage(let pageNumber):
                return "/character/?page=\(pageNumber)"
            case .getSingleCharacter(let id):
                return "/character/\(id)"
            }
        }
    }
    
    private let networkManager = NetworkManager.shared
    
    func getCharactersByPage(number: Int, completion: @escaping (Result<CharactersResponse, NetworkError>) -> Void) {
        networkManager.sendRequest(
            endpoint: Endpoints.getCharactersByPage(number),
            completion: { (result: Result<CharactersResponse, NetworkError>) in
                switch result {
                case .success(let characters):
                    completion(.success(characters))
                    
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        )
    }
    
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
    
    func getCharacters(url: String, completion: @escaping (Result<CharactersResponse, NetworkError>) -> Void) {
        networkManager.sendRequestWithURL(
            url: url,
            completion: { (result: Result<CharactersResponse, NetworkError>) in
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
