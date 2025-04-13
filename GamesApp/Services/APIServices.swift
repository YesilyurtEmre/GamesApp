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
  func fetchGames(page: Int, completion: @escaping (Result<[Game], Error>) -> Void) {
    let url = "\(EndPoint.games.url)&page=\(page)"
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
  func searchGames(query: String, page: Int = 1, completion: @escaping (Result<[Game], Error>) -> Void) {
    guard let encodedQuery = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
      completion(.failure(NSError(domain: "",
                                  code: -1,
                                  userInfo: [NSLocalizedDescriptionKey: "Invalid search query."])))
      return
    }
    let urlString = "\(EndPoint.baseURL)/games"
    let parameters: [String: Any] = [
      "key": EndPoint.apiKey,
      "search": encodedQuery,
      "page": page
    ]
    AF.request(urlString, parameters: parameters)
      .validate()
      .responseDecodable(of: GameResponse.self) { response in
        switch response.result {
        case .success(let result):
          completion(.success(result.results))
        case .failure(let error):
          completion(.failure(error))
        }
      }
  }
}
