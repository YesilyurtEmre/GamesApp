//
//  GamesViewModel.swift
//  GamesApp
//
//  Created by Emre Yeşilyurt on 20.03.2025.
//

import Foundation

class GamesViewModel {
    private var games: [Game] = [
        Game(title: "Grand Theft Auto V", metacriticScore: 96, genre: "Action, Shooter", imageName: "GTA"),
        Game(title: "Portal 2", metacriticScore: 96, genre: "Action, Shooter", imageName: "Portal"),
        Game(title: "The Witcher 3: Wild Hunt", metacriticScore: 96, genre: "Action, Shooter", imageName: "Witcher")
    ]
    
    var numberOfGames: Int {
        return games.count
    }
    
    func game(at index: Int) -> Game {
        return games[index]
    }
}
