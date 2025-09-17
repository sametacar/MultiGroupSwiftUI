//
//  NoteDataManager.swift
//  odev_coreData
//
//  Created by vili on 16.09.2025.
//

import Foundation
import CoreData

protocol CoreDataManagerProtocol {
    var context: NSManagedObjectContext { get }
    func saveContext()
    func fetch<T: NSManagedObject>(_ type: T.Type) -> [T]
}

final class CoreDataManager: CoreDataManagerProtocol {
    
    static let shared = CoreDataManager()
    var context: NSManagedObjectContext {
            persistentContainer.viewContext
    }
    
    private init() {
        context.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
    }
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "NoteDatabase")
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error)")
            }
        }
        
        return container
    }()
    
    func saveContext() {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                debugPrint("CoreData save error: \(error.localizedDescription)")
            }
        }
    }
    
    func fetch<T: NSManagedObject>(_ type: T.Type) -> [T] {
        do {
            return try context.fetch(type.fetchRequest()) as? [T] ?? []
        } catch {
            debugPrint("Fetch for type \(type) failed: \(error)")
            return []
        }
    }
}
