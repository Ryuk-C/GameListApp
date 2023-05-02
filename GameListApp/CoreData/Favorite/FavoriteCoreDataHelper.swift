//
//  FavoriteCoreDataHelper.swift
//  GameListApp
//
//  Created by Cuma Haznedar on 02/05/2023.
//

import CoreData
import UIKit

final class CoreDataFavoriteHelper {
    
    static let shared = CoreDataFavoriteHelper()

    let persistentContainer = NSPersistentContainer(name: "GameListApp")
    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
     init() {
        persistentContainer.loadPersistentStores { _, error in
            if let error {
                fatalError(error.localizedDescription)
            }
        }
    }
    
    func save() {
        try? self.context.save()
    }
    
    func getFavorites() -> [Favorite]? {
        return try? self.context.fetch(Favorite.fetchRequest())
    }

    func addFavorite(name: String, imageURL: String) {
        let favorite = Favorite(context: context)
        favorite.name = name
        favorite.imageUrl = imageURL
        save()
    }

    func deleteFavorite(index: Int) {
        if let favs = getFavorites() {
            context.delete(favs[index])
            save()
        }
    }
}
