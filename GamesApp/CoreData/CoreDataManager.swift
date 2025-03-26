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
    
    func addToFavorites(game: Game) {
        let favoriteGame = FavouriteGame(context: context)
        favoriteGame.id =  UUID(uuidString: String(game.id)) ?? UUID()
        favoriteGame.name = game.name
        favoriteGame.imageURL = game.background_image
        favoriteGame.genres = game.genres.map { $0.name }.joined(separator: ", ")
        favoriteGame.metacritic = Int16(game.metacritic ?? 0)
        
        saveContext()
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
    
    func removeFromFavorites(id: String) {
        let fetchRequest: NSFetchRequest<FavouriteGame> = FavouriteGame.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", id)
        
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
    
    func isFavorite(id: String) -> Bool {
        let fetchRequest: NSFetchRequest<FavouriteGame> = FavouriteGame.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", id)
        
        do {
            let count = try context.count(for: fetchRequest)
            return count > 0
        } catch {
            print("Favori kontrol edilirken hata oluştu: \(error)")
            return false
        }
    }
}

