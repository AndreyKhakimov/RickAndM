//
//  CharacterInfoViewModel.swift
//  RickAndM
//
//  Created by Andrey Khakimov on 02.05.2022.
//

import Foundation

protocol CharacterInfoViewModelProtocol {
    var id: Int { get }
    var characterImage: String { get }
    var characterDescription: String { get }
    var viewModelDidChange: ((CharacterInfoViewModelProtocol) -> Void)? { get set }
    
    init(id: Int)
    
    func viewDidLoad()
}

class CharacterInfoViewModel: CharacterInfoViewModelProtocol {
    
    var id: Int
    
    var characterDescription: String {
        character?.description ?? ""
    }
    
    var characterImage: String {
        character?.image ?? ""
    }
    
    var viewModelDidChange: ((CharacterInfoViewModelProtocol) -> Void)?
    
    private var character: Character?
    private let charactersNetworkManager = CharactersNetworkManager()
    
    required init(id: Int) {
        self.id = id
    }
    
    func viewDidLoad() {
        fetchData(with: id)
    }
    
    private func fetchData(with id: Int) {
        charactersNetworkManager.getCharacter(
            id: id,
            completion: { [weak self] result in
                DispatchQueue.main.async { [self] in
                    guard let self = self else { return }
                    
                    switch result {
                    case .success(let character):
                        self.character = character
                    case .failure(let error):
                        break
                        // TODO: - Fix show alert issue
//                        self.showAlert(title: error.title, message: error.description)
                    }
                    self.viewModelDidChange?(self)
                }
            }
        )
    }
    
}
