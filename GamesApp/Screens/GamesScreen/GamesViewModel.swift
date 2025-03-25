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
    
    var onGamesFetched: (() -> Void)?
    var onError: ((String) -> Void)?
    var onFavoritesChanged: (() -> Void)?
    
    var numberOfGames: Int {
        return gameItems.count
    }
    
    
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
    
    func filterGames(by searchText: String) -> [GameViewModelItem] {
        return gameItems.filter { game in
            return game.title.lowercased().contains(searchText.lowercased())
        }
    }
    
    func addToFavorites(game: Game) {
        CoreDataManager.shared.addToFavorites(game: game)
        onFavoritesChanged?()
    }
    
    func isFavorite(id: Int) -> Bool {
        return CoreDataManager.shared.isFavorite(id: String(id))
    }
    
    func removeFromFavorites(id: Int) {
        CoreDataManager.shared.removeFromFavorites(id: String(id))
        onFavoritesChanged?()
    }
}
