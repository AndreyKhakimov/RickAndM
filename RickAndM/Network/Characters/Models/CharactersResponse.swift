//
//  CharactersResponse.swift
//  RickAndM
//
//  Created by Andrey Khakimov on 15.04.2022.
//

import Foundation

struct CharactersResponse: Decodable {
    let info: Info
    let results: [Character]
}

struct Info: Decodable {
    let pages: Int
    let next: String?
    let prev: String?
}
