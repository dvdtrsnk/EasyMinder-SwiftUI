//
//  Category+CoreDataProperties.swift
//  EasyMinder-SwiftUI
//
//  Created by David Třešňák on 27.06.2023.
//
//

import Foundation
import CoreData
import SwiftUI


extension Category {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Category> {
        return NSFetchRequest<Category>(entityName: "Category")
    }

    @NSManaged public var name: String?
    @NSManaged public var id: UUID?
    @NSManaged public var icon: String?
    @NSManaged public var color: String?
    @NSManaged public var dateCreated: Date?
    @NSManaged public var items: NSSet?
    
    public var wrappedName: String {
        name ?? "Unknown Category"
    }
    
    public var wrappedId: UUID {
        id ?? UUID()
    }
    
    public var wrappedIcon: Image {
        if let icon = icon {
            return Image(systemName: icon)
        } else {
            return Image(systemName: "xmark")

        }
    }
    
    public var wrappedColor: Color {
        Color.fromRGBString(color ?? "")
    }
    
    public var wrappedDateCreated: Date {
        dateCreated ?? Date.now
    }
    
    public var wrappedItems: [Item] {
        let set = items as? Set<Item> ?? []
        return set.sorted {
            $0.wrappedName < $1.wrappedName
        }
    }

}

// MARK: Generated accessors for items
extension Category {

    @objc(addItemsObject:)
    @NSManaged public func addToItems(_ value: Item)

    @objc(removeItemsObject:)
    @NSManaged public func removeFromItems(_ value: Item)

    @objc(addItems:)
    @NSManaged public func addToItems(_ values: NSSet)

    @objc(removeItems:)
    @NSManaged public func removeFromItems(_ values: NSSet)

}

extension Category : Identifiable {

}
