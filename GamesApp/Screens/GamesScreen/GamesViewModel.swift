//
//  GamesViewModel.swift
//  GamesApp
//
//  Created by Emre Yeşilyurt on 20.03.2025.
//

import Foundation

struct GameViewModelItem {
    let id: Int
    let title: String
    let metacritic: String
    let genres: String
    let imageURL: String
}

class GamesViewModel {
    
    private var games: [Game] = []
    private(set) var gameItems: [GameViewModelItem] = []
    
    var numberOfGames: Int {
        return gameItems.count
    }
    
    func game(at index: Int) -> GameViewModelItem {
        return gameItems[index]
    }
    
    func fetchGames(completion: @escaping () -> Void) {
        APIService.shared.fetchGames { [weak self] result in
            switch result {
            case .success(let games):
                self?.games = games
                self?.gameItems = games.map {
                    GameViewModelItem(
                        id: $0.id,
                        title: $0.name,
                        metacritic: String($0.metacritic ?? 0),
                        genres: $0.genres.map { $0.name }.joined(separator: ", "),
                        imageURL: $0.background_image ?? ""
                    )
                }
                completion()
            case .failure(let error):
                print("Fetch games error: \(error.localizedDescription)")
                completion()
            }
        }
    }
}
