//
//  GameDetail.swift
//  GamesApp
//
//  Created by Emre Yeşilyurt on 21.03.2025.
//

import Foundation

struct GameDetail: Decodable {
    let id: Int
    let name: String
    let backgroundImage: String?
    let description: String
    let website: String?
    let redditURL: String?
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case backgroundImage = "background_image"
        case description
        case website
        case redditURL = "reddit_url"
    }
}
