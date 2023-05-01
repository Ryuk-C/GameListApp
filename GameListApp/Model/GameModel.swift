//
//  GameModel.swift
//  GameListApp
//
//  Created by Cuma Haznedar on 01/05/2023.
//

import Foundation

struct BaseResponse: Codable {
    
    let results: [Game]
}

struct Game: Codable {
    
    let id: Int?
    let name: String?
    let released: String?
    let backgroundImage: String?
    
    enum CodingKeys: String, CodingKey {
        
        case id, name, released
        case backgroundImage = "background_image"
    }
}
