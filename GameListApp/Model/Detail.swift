//
//  Detail.swift
//  GameListApp
//
//  Created by Cuma Haznedar on 01/05/2023.
//

import Foundation

struct Detail: Codable {
    
    let name: String?
    let description: String?
    let backgroundImage: String?
    let website: String?
    
    enum CodingKeys: String, CodingKey {
        case name, description, website
        case backgroundImage = "background_image"
    }
}
