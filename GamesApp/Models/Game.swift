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
    let backgroundImage: String?
    let metacritic: Int?
    let genres: [Genre]
    let description: String?
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case backgroundImage = "background_image"
        case metacritic
        case genres
        case description
    }
}

struct Genre: Decodable {
    let name: String
}
