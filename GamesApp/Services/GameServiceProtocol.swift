//
//  GameServiceProtocol.swift
//  GamesApp
//
//  Created by Emre Yeşilyurt on 8.04.2025.
//

import Foundation

protocol GameServiceProtocol {
    func fetchGames(page: Int, completion: @escaping (Result<[Game], Error>) -> Void)
}

class GameService: GameServiceProtocol {
    func fetchGames(page: Int, completion: @escaping (Result<[Game], Error>) -> Void) {
        APIService.shared.fetchGames(page: page, completion: completion)
    }
}

