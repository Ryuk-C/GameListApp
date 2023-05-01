//
//  GameService.swift
//  GameListApp
//
//  Created by Cuma Haznedar on 01/05/2023.
//

import Foundation
import Alamofire

protocol GameServiceProtocol {
    func fetchGames(page: Int, pageSize: Int, paging: Bool, newUrl: String, completion: @escaping (Result<BaseResponse?, AFError>) -> Void)
    func fetchDetail(id: Int, completion: @escaping (Result<Detail?, AFError>) -> Void)
}

struct GameService: GameServiceProtocol {

    func fetchGames(page: Int, pageSize: Int, paging: Bool, newUrl: String, completion: @escaping (Result<BaseResponse?, Alamofire.AFError>) -> Void) {

        var url: String {
            switch paging {
            case true:
                return newUrl
            case false:
                return "\(GameListEndpoints.getList.url)\(GameListEndpoints.getList.apiKey)"
            }
        }

        let parameters: Parameters = [
            "page": page,
            "page_size": pageSize]
        
        NetworkManager.shared.sendRequest(
            type: BaseResponse.self, url: url, method: .get, parameters: parameters,
            completion: { response in
            
            switch response {
            case .success(let games):
                completion(.success(games))

            case .failure(let error):
                completion(.failure(error))
            }
        }
    )
    }

    func fetchDetail(id: Int, completion: @escaping (Result<Detail?, Alamofire.AFError>) -> Void) {
    }
    }
