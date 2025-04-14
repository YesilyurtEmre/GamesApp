//
//  GameServiceProtocol.swift
//  GamesApp
//
//  Created by Emre Yeşilyurt on 9.04.2025.
//

import Foundation
protocol GameServiceProtocol {
  func fetchGames(page: Int, completion: @escaping (Result<[Game], Error>) -> Void)
  func fetchGameDetails(gameId: Int, completion: @escaping (Result<GameDetail, Error>) -> Void)
}
