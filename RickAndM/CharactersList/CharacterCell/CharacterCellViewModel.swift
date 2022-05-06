//
//  CharacterCellViewModel.swift
//  RickAndM
//
//  Created by Andrey Khakimov on 03.05.2022.
//

import Foundation

protocol CharacterCellViewModelProtocol {
    var characterName: String { get }
    var characterSmallDescription: String { get }
    var characterImage: String? { get }
    init(character: Character)
}

class CharacterCellViewModel: CharacterCellViewModelProtocol {
    var characterName: String {
        character.name
    }
    
    var characterSmallDescription: String {
        character.smallDescription
    }
    
    var characterImage: String? {
        character.image
    }
    
    private var character: Character
    
    required init(character: Character) {
        self.character = character
    }
    
    
}
