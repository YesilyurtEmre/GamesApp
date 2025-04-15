//
//  APIServices.swift
//  GamesApp
//
//  Created by Emre Yeşilyurt on 21.03.2025.
//

import Foundation
import Alamofire

class APIService: GameServiceProtocol {
  static let shared = APIService()
  private init() {}
  func searchGames(query: String, page: Int = 1, completion: @escaping (Result<[Game], Error>) -> Void) {
    guard let encodedQuery = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
      completion(.failure(NSError(domain: "",
                                  code: -1,
                                  userInfo: [NSLocalizedDescriptionKey: "Invalid search query."])))
      return
    }
    let url = "\(EndPoint.baseURL)/games"
    let parameters: [String: Any] = [
      "key": EndPoint.apiKey,
      "search": encodedQuery,
      "page": page
    ]
    performRequest(url: url, parameters: parameters, responseType: GameResponse.self) { result in
      switch result {
      case .success(let response):
        completion(.success(response.results))
      case .failure(let error):
        completion(.failure(error))
      }
    }
  }
  func fetchGames(page: Int, completion: @escaping (Result<[Game], Error>) -> Void) {
    let url = "\(EndPoint.games.url)&page=\(page)"
    performRequest(url: url, responseType: GameResponse.self) { result in
      switch result {
      case .success(let response):
        completion(.success(response.results))
      case .failure(let error):
        completion(.failure(error))
      }
    }
  }
  func fetchGameDetails(gameId: Int, completion: @escaping (Result<GameDetail, Error>) -> Void) {
    let url = "\(EndPoint.baseURL)/games/\(gameId)?key=\(EndPoint.apiKey)"
    performRequest(url: url, responseType: GameDetail.self, completion: completion)
  }
  // MARK: - Private Helper
  private func performRequest<T: Decodable>(
    url: String,
    parameters: [String: Any]? = nil,
    responseType: T.Type,
    completion: @escaping (Result<T, Error>) -> Void
  ) {
    AF.request(url, parameters: parameters)
      .validate()
      .responseDecodable(of: responseType) { response in
        switch response.result {
        case .success(let decodedData):
          completion(.success(decodedData))
        case .failure(let error):
          completion(.failure(error))
        }
      }
  }
}
