//
//  EndpointProtocol.swift
//  ContactsList
//
//  Created by Andrey Khakimov on 14.04.2022.
//

import Foundation

protocol EndpointProtocol {
    static var hostURL: String { get }
    
    var query: String { get }
    var url: URL { get }
    var httpMethod: String { get }
}

extension EndpointProtocol {
    static var hostURL: String { NetworkManager.hostUrl }
    
    var url: URL { URL(string: Self.hostURL + query)! }
    var httpMethod: String { "GET" }
}
