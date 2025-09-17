//
//  NoteRepository.swift
//  odev_coreData
//
//  Created by vili on 16.09.2025.
//

import Foundation
import CoreData

protocol NoteRepositoryProtocol {
    func getAllNotes() -> [Note]
    func add(note: Note)
    func delete(note: Note)
    func update(note: Note)
}

final class NoteRepository: NoteRepositoryProtocol {
    private let coreData: CoreDataManagerProtocol

    init(coreData: CoreDataManagerProtocol = CoreDataManager.shared) {
        self.coreData = coreData
    }

    func getAllNotes() -> [Note] {
        let entities: [NoteEntity] = coreData.fetch(NoteEntity.self)
        return entities.map { $0.toNote() }
    }

    func add(note: Note) {
        let entity = NoteEntity(context: coreData.context)
        entity.id = note.id
        entity.title = note.title
        entity.content = note.content
        entity.date = note.date
        coreData.saveContext()
    }

    func delete(note: Note) {
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "NoteEntity")
        request.predicate = NSPredicate(format: "id == %@", note.id as CVarArg)
        request.fetchLimit = 1
        do {
            if let results = try coreData.context.fetch(request) as? [NoteEntity], let entity = results.first {
                coreData.context.delete(entity)
                coreData.saveContext()
            }
        } catch {
            debugPrint("Delete error: \(error)")
        }
    }

    func update(note: Note) {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "NoteEntity")
            request.predicate = NSPredicate(format: "id == %@", note.id as CVarArg)
            request.fetchLimit = 1
            
        do {
            if let results = try coreData.context.fetch(request) as? [NoteEntity],
               let entity = results.first {
                entity.title = note.title
                entity.content = note.content
                
                coreData.saveContext()
            }
        } catch {
            debugPrint("Update error: \(error)")
        }
    }
}
