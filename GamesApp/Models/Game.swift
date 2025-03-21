//
//  Game.swift
//  GamesApp
//
//  Created by Emre Yeşilyurt on 20.03.2025.
//

import Foundation

struct GameResponse: Decodable {
    let results: [Game]
}

struct Game: Decodable {
    let id: Int
    let name: String
    let background_image: String?
    let metacritic: Int?
    let genres: [Genre]
}

struct Genre: Decodable {
    let name: String
}
