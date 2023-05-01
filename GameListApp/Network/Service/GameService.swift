//
//  GameService.swift
//  GameListApp
//
//  Created by Cuma Haznedar on 01/05/2023.
//

import Foundation
import Alamofire

protocol GameServiceProtocol {
    func fetchGames(completion: @escaping (Result<[Game]?, AFError>) -> Void)
    func fetchDetail(id: Int, completion: @escaping (Result<Detail?, AFError>) -> Void)
}

struct GameService : GameServiceProtocol {
    
    func fetchGames(completion: @escaping (Result<[Game]?, Alamofire.AFError>) -> Void) {
        
    }
    
    func fetchDetail(id: Int, completion: @escaping (Result<Detail?, Alamofire.AFError>) -> Void) {
        
    }
}
