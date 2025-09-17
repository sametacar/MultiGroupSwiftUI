//
//  NoteEntity+Mapping.swift
//  odev_coreData
//
//  Created by vili on 16.09.2025.
//
import Foundation

extension NoteEntity {
    func toNote() -> Note {
        Note(
            id: self.id ?? UUID(),
            title: self.title ?? "",
            content: self.content ?? "",
            date: self.date ?? Date()
        )
    }
}
