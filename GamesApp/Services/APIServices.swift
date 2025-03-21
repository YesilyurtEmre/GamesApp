//
//  APIServices.swift
//  GamesApp
//
//  Created by Emre Yeşilyurt on 21.03.2025.
//

import Foundation
import Alamofire

class APIService {
    static let shared = APIService()
    private init() {}
    
    func fetchGames(completion: @escaping (Result<[Game], Error>) -> Void) {
        let url = EndPoint.games.url
        
        AF.request(url)
            .validate()
            .responseDecodable(of: GameResponse.self) { response in
                switch response.result {
                case .success(let gameResponse):
                    completion(.success(gameResponse.results))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
}
