//
//  NoteEntity+CoreDataProperties.swift
//  odev_coreData
//
//  Created by vili on 16.09.2025.
//

import Foundation
import CoreData

extension NoteEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<NoteEntity> {
        return NSFetchRequest<NoteEntity>(entityName: "Note")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var title: String?
    @NSManaged public var content: String?
    @NSManaged public var date: Date?
}

