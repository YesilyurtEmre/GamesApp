//
//  FavouritesViewModel.swift
//  GamesApp
//
//  Created by Emre Yeşilyurt on 27.03.2025.
//

import Foundation

class FavouritesViewModel {
  private var favouriteGames: [FavouriteGame] = []
  var onFavouritesUpdated: (() -> Void)?
  var onError: ((String) -> Void)?
  func fetchFavourites() {
    favouriteGames = CoreDataManager.shared.getFavoriteGames().reversed()
    onFavouritesUpdated?()
  }
  func numberOfFavourites() -> Int {
    return favouriteGames.count
  }
  func favouriteGame(at index: Int) -> FavouriteGame {
    return favouriteGames[index]
  }
  func getTitleWithCount() -> String {
    let count = numberOfFavourites()
    return count > 0 ? "Favourites (\(count))" : "Favourites"
  }
  func isEmpty() -> Bool {
    return favouriteGames.isEmpty
  }
  func deleteFavourite(game: FavouriteGame) {
    let gameId = game.id
    CoreDataManager.shared.removeFromFavorites(id: gameId)
    fetchFavourites()
  }
}
