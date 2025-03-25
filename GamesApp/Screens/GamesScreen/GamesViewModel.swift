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
    
    var onGamesFetched: (() -> Void)?
    var onError: ((String) -> Void)?
    
    func game(at index: Int) -> GameViewModelItem {
        return gameItems[index]
    }
    
    func fetchGames() {
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
                self?.onGamesFetched?()
            case .failure(let error):
                self?.onError?(error.localizedDescription)
            }
        }
    }
}
