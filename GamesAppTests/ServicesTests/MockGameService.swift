//
//  MockGameService.swift
//  GamesAppTests
//
//  Created by Emre Yeşilyurt on 15.04.2025.
//

import Foundation
@testable import GamesApp
final class MockGameService: GameServiceProtocol {
  var result: Result<[Game], Error>!
  var searchResult: Result<[Game], Error>?
  var gameDetailResult: Result<GameDetail, Error>!
  func searchGames(query: String, page: Int, completion: @escaping (Result<[GamesApp.Game], any Error>) -> Void) {
    if let result = searchResult {
      completion(result)
    }
  }
  func fetchGames(page: Int, completion: @escaping (Result<[Game], Error>) -> Void) {
    if let result = result {
      completion(result)
    }
  }
  func fetchGameDetails(gameId: Int, completion: @escaping (Result<GameDetail, Error>) -> Void) {
    if let result = gameDetailResult {
      completion(result)
    }
  }
}
