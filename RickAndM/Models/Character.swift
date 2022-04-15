//
//  Character.swift
//  RickAndM
//
//  Created by Andrey Khakimov on 15.04.2022.
//

import Foundation

struct Character: Decodable {
    let name: String
    let status: String
    let species: String
    let gender: String
    let origin: Origin
    let location: Location
    let image: String
    let episode: [String]
    let url: String
    let created: String
    
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
}

struct Origin: Decodable {
    let name: String
}

struct Location: Decodable {
    let name: String
}

