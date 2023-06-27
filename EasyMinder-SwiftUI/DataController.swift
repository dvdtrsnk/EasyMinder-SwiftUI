//
//  DataController.swift
//  EasyMinder-SwiftUI
//
//  Created by David Třešňák on 27.06.2023.
//

import Foundation

import CoreData
import Foundation

class DataController: ObservableObject {
    let container = NSPersistentContainer(name: "EasyMinder-SwiftUI")
    
    init() {
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Core Data failed to load: \(error.localizedDescription)")
            }
        }
    }
}
