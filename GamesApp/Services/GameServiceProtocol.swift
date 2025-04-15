//
//  GameServiceProtocol.swift
//  GamesApp
//
//  Created by Emre Yeşilyurt on 15.04.2025.
//

import Foundation
protocol GameServiceProtocol {
  func fetchGames(page: Int, completion: @escaping (Result<[Game], Error>) -> Void)
  func fetchGameDetails(gameId: Int, completion: @escaping (Result<GameDetail, Error>) -> Void)
  func searchGames(query: String, page: Int, completion: @escaping (Result<[Game], Error>) -> Void)
}
