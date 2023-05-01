//
//  NetworkManager.swift
//  GameListApp
//
//  Created by Cuma Haznedar on 01/05/2023.
//

import Alamofire
import Foundation

struct NetworkManager {
    static let shared = NetworkManager()
}

extension NetworkManager {
    
    func sendRequest<T: Codable>(type: T.Type,
                                 url: String,
                                 method: HTTPMethod,
                                 parameters: Parameters,
                                 completion: @escaping ((Result<T, AFError>) -> Void)) {
        
        AF.request(url,
                   method: method,
                   encoding: JSONEncoding.default)
        .validate()
        .responseDecodable(of: T.self) { response in
            
            switch response.result {
            case .success(let data):
                completion(.success(data))
                
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
