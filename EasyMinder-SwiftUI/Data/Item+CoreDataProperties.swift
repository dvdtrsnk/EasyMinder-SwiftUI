//
//  Item+CoreDataProperties.swift
//  EasyMinder-SwiftUI
//
//  Created by David Třešňák on 27.06.2023.
//
//

import Foundation
import CoreData


extension Item {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Item> {
        return NSFetchRequest<Item>(entityName: "Item")
    }

    @NSManaged public var name: String?
    @NSManaged public var id: UUID?
    @NSManaged public var dueDate: Date?
    @NSManaged public var notes: String?
    @NSManaged public var dateCreated: Date?
    @NSManaged public var notification: Bool
    @NSManaged public var parentCategory: Category?

}

extension Item : Identifiable {

}
