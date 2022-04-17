//
//  Character.swift
//  RickAndM
//
//  Created by Andrey Khakimov on 15.04.2022.
//

import Foundation

struct Character: Decodable {
    let id: Int
    let name: String
    let status: String
    let species: String
    let gender: String
    let location: Location
    let image: String
    let episode: [String]
    
    var description: String {
    """
    Name: \(name)
    Species: \(species)
    Gender: \(gender)
    Status: \(status)
    Location: \(location.name)
    Episodes: \(episode.count)
    """
    }
    
    var smallDescription: String {
        "\(gender), \(species)"
    }
}

struct Location: Decodable {
    let name: String
}

