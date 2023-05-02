//
//  Favorite+CoreDataProperties.swift
//  GameListApp
//
//  Created by Cuma Haznedar on 02/05/2023.
//
//

import CoreData
import Foundation

extension Favorite {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Favorite> {
        return NSFetchRequest<Favorite>(entityName: "Favorite")
    }

    @NSManaged public var name: String?
    @NSManaged public var imageUrl: String?
}

extension Favorite: Identifiable {}
