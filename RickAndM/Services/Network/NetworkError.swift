//
//  NetworkError.swift
//  ContactsList
//
//  Created by Andrey Khakimov on 14.04.2022.
//

import Foundation

enum NetworkError: Error {
    case noData
    case decodingError
    case cancelled
    case other(Error)
    
    var title: String {
        "Error"
    }
    
    var description: String {
        switch self {
        case .noData:
            return "The data received from the server is invalid"
            
        case .decodingError:
            return "The data can not be decoded"
            
        case .cancelled:
            return "Request has been cancelled"
            
        case .other(let error):
            return error.localizedDescription
        }
    }
}
