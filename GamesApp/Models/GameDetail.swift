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
    let background_image: String?
    let description: String
    let website: String?
    let reddit: String?
}
