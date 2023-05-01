//
//  ServiceEndpointProtocols.swift
//  GameListApp
//
//  Created by Cuma Haznedar on 01/05/2023.
//

import Foundation

protocol ServiceEndpointProtocols {
    
    var baseURLString: String { get }
    var path: String { get }
    var apiKey: String { get }
}

extension ServiceEndpointProtocols {
    var url: String {
        return baseURLString + path
    }
}
