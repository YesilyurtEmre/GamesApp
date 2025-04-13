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
  private var currentPage = 1
  private var isFetching = false
  var numberOfGames: Int {
    return gameItems.count
  }
  var isLoading: Bool = false {
    didSet {
    }
  }
  func game(at index: Int) -> GameViewModelItem {
    return gameItems[index]
  }
  func fetchGames() {
    guard !isFetching else { return }
    isFetching = true
    isLoading = true
    APIService.shared.fetchGames(page: currentPage) { [weak self] result in
      guard let self = self else { return }
      self.isFetching = false
      self.isLoading = false
      switch result {
      case .success(let games):
        self.games.append(contentsOf: games)
        self.gameItems.append(contentsOf: games.map {
          GameViewModelItem(
            id: $0.id,
            title: $0.name,
            metacritic: String($0.metacritic ?? 0),
            genres: $0.genres.map { $0.name }.joined(separator: ", "),
            imageURL: $0.backgroundImage ?? ""
          )
        })
        self.currentPage += 1
        self.onGamesFetched?()
      case .failure(let error):
        self.onError?(error.localizedDescription)
      }
    }
  }
  func searchGames(with query: String, completion: @escaping ([GameViewModelItem]) -> Void) {
    APIService.shared.searchGames(query: query) { [weak self] result in
      switch result {
      case .success(let games):
        let items = games
          .filter { $0.name.lowercased().starts(with: query.lowercased()) }
          .map {
            GameViewModelItem(
              id: $0.id,
              title: $0.name,
              metacritic: String($0.metacritic ?? 0),
              genres: $0.genres.map { $0.name }.joined(separator: ", "),
              imageURL: $0.backgroundImage ?? ""
            )
          }
        completion(items)
      case .failure(let error):
        self?.onError?(error.localizedDescription)
        completion([])
      }
    }
  }
}
