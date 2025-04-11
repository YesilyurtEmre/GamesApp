//
//  CoreDataManager.swift
//  GamesApp
//
//  Created by Emre Yeşilyurt on 25.03.2025.
//

import CoreData
import UIKit

class CoreDataManager {
  static let shared = CoreDataManager()
  private init() {}
  lazy var persistentContainer: NSPersistentContainer = {
    let container = NSPersistentContainer(name: "GamesModel")
    container.loadPersistentStores { _, error in
      if let error = error as NSError? {
        print("Core Data yüklenirken hata oluştu: \(error), \(error.userInfo)")
      }
    }
    return container
  }()
  var context: NSManagedObjectContext {
    return persistentContainer.viewContext
  }
  func saveContext() {
    guard context.hasChanges else { return }
    do {
      try context.save()
    } catch let error as NSError {
      print("Core Data kaydetme hatası: \(error), \(error.userInfo)")
    }
  }
}

extension CoreDataManager {
  func addToFavorites(gameItem: GameViewModelItem) {
    let favoriteGame = FavouriteGame(context: context)
    favoriteGame.id = Int32(gameItem.id)
    favoriteGame.name = gameItem.title
    favoriteGame.imageURL = gameItem.imageURL
    favoriteGame.genres = gameItem.genres
    favoriteGame.metacritic = gameItem.metacritic
    do {
      try context.save()
      print("\(gameItem.title) favorilere eklendi.")
    } catch {
      print("Core Data save error: \(error)")
    }
  }
  func getFavoriteGames() -> [FavouriteGame] {
    let fetchRequest: NSFetchRequest<FavouriteGame> = FavouriteGame.fetchRequest()
    do {
      return try context.fetch(fetchRequest)
    } catch {
      print("Favori oyunları çekerken hata oluştu: \(error)")
      return []
    }
  }
  func removeFromFavorites(id: Int32) {
    let fetchRequest: NSFetchRequest<FavouriteGame> = FavouriteGame.fetchRequest()
    fetchRequest.predicate = NSPredicate(format: "id == %d", id)
    do {
      let games = try context.fetch(fetchRequest)
      for game in games {
        context.delete(game)
      }
      saveContext()
    } catch {
      print("Favori oyunu silerken hata oluştu: \(error)")
    }
  }
  func isFavorite(id: Int32) -> Bool {
    let fetchRequest: NSFetchRequest<FavouriteGame> = FavouriteGame.fetchRequest()
    fetchRequest.predicate = NSPredicate(format: "id == %d", id)
    do {
      let count = try context.count(for: fetchRequest)
      return count > 0
    } catch {
      print("Favori kontrol edilirken hata oluştu: \(error)")
      return false
    }
  }
}
