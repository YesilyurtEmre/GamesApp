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
    
    func fetchGameDetails(gameId: Int, completion: @escaping (Result<GameDetail, Error>) -> Void) {
        let url = "\(EndPoint.baseURL)/games/\(gameId)?key=\(EndPoint.apiKey)"
        
        AF.request(url)
            .validate()
            .responseDecodable(of: GameDetail.self) { response  in
                switch response.result {
                case .success(let gameDetail):
                    completion(.success(gameDetail))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
}
