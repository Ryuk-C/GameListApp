//
//  GameListEndpoints.swift
//  GameListApp
//
//  Created by Cuma Haznedar on 01/05/2023.
//

import Foundation

enum GameListEndpoints: ServiceEndpointProtocols {
    
    case getList
    case getDetail
    
    var baseURLString: String {
        switch self {
        case .getList:
            return "https://api.rawg.io/api"
        case .getDetail:
            return "https://api.rawg.io/api"
        }
    }
    
    var path: String {
        switch self {
        case .getList:
            return "/games?"
        case .getDetail:
            return "/games/"
        }
    }
    
    var apiKey: String {
        switch self {
        case .getList:
            return "key=11df07d8e7584ce68ab7fd4c9b241e80"
        case .getDetail:
            return "key=11df07d8e7584ce68ab7fd4c9b241e80"
        }
    }
}
