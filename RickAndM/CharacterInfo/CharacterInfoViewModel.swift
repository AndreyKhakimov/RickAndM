//
//  CharacterInfoViewModel.swift
//  RickAndM
//
//  Created by Andrey Khakimov on 02.05.2022.
//

import Foundation

protocol CharacterInfoViewModelProtocol {
    var characterImage: String { get }
    var characterDescription: String { get }
    init(character: Character)
}

class CharacterInfoViewModel: CharacterInfoViewModelProtocol {
    var characterDescription: String {
        character.description
    }
    var characterImage: String {
        character.image
    }
    
    private let character: Character
    
    required init(character: Character) {
        self.character = character
    }
    
}
