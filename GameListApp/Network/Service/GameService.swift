//
//  GameService.swift
//  GameListApp
//
//  Created by Cuma Haznedar on 01/05/2023.
//

import Alamofire
import Foundation

protocol GameServiceProtocol {
    func fetchGames(
        pageSize: Int, paging: Bool, newUrl: String, completion: @escaping (Result<BaseResponse?, AFError>
        ) -> Void)

    func fetchDetail(id: Int, completion: @escaping (Result<Detail?, AFError>) -> Void)
}

struct GameService: GameServiceProtocol {

    func fetchGames(
        pageSize: Int, paging: Bool, newUrl: String, completion: @escaping (Result<BaseResponse?, Alamofire.AFError>
        ) -> Void) {

        var url: String {
            switch paging {

            case true:
                return newUrl

            case false:
                return "\(GameListEndpoints.getList.url)\(GameListEndpoints.getList.apiKey)"
            }
        }

        NetworkManager.shared.sendRequest(
            type: BaseResponse.self, url: url, method: .get,
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

        let url = "\(GameListEndpoints.getDetail.url)\(id)?\(GameListEndpoints.getDetail.apiKey)"

        NetworkManager.shared.sendRequest(
            type: Detail.self, url: url, method: .get, completion: { details in

                switch details {

                case .success(let detail):
                    print("ccc")
                    print(url)
                    print(detail)
                    completion(.success(detail))

                case .failure(let error):
                    completion(.failure(error))
                }
            })
    }
}
