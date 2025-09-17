//
//  ContentViewModel.swift
//  odev_userDefaults
//
//  Created by vili on 12.09.2025.
//

import Foundation
import CoreData

class ContentViewModel: ObservableObject {
    //: MARK - Properties
    @Published var notes: [Note] = []
    @Published var showAddCover: Bool = false
    //private let coreData = CoreDataManager.shared
    private let repository: NoteRepositoryProtocol
    
    init(repository: NoteRepositoryProtocol = NoteRepository()) {
            self.repository = repository
            loadNotes()
    }
    
    func pushAddNoteButton () {
        showAddCover.toggle()
    }
    
    private func loadNotes() {
        notes = repository.getAllNotes().sorted(by: { $0.date > $1.date })
    }
    
    func addNewNote(title: String, content: String) {
        
        let note = Note(id: UUID(), title: title, content: content, date: Date())
        repository.add(note: note)
        loadNotes()
    }
    
    func deleteNote(id: UUID) {
        if let note = notes.first(where: { $0.id == id }) {
            repository.delete(note: note)
            // load note list again
            loadNotes()
        }
    }
    
    func updateNote(note: Note) {
        repository.update(note: note)
        loadNotes()
    }
}
