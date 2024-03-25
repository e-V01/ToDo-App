//
//  Persistence.swift
//  Todo App
//
//  Created by Y K on 25.03.2024.
//

import CoreData

public class PersistenceController {
    public static let shared = PersistenceController()

    public var container: NSPersistentContainer

    public init() {
        container = NSPersistentContainer(name: "Todo")
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
    }
}

