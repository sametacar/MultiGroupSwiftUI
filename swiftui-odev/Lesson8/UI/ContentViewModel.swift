//
//  ContentViewModel.swift
//  odev_userDefaults
//
//  Created by vili on 12.09.2025.
//

import Foundation

class ContentViewModel: ObservableObject {
    //: MARK - Properties
    @Published var notes: [Note] = []
    @Published var showAddCover: Bool = false
    
    init() {
        loadNotes()
    }
    
    func pushAddNoteButton () {
        showAddCover.toggle()
    }
    
    private func loadNotes() {
        if let data = UserDefaults.standard.data(forKey: "list"),
           let decoded = try? JSONDecoder().decode([Note].self, from: data) {
            notes = decoded
        } else {
            notes = []
        }
    }
    
    /// encode notes and save UserDefaults
    func saveNotes() {
        if let encoded = try? JSONEncoder().encode(notes) {
            UserDefaults.standard.set(encoded, forKey: "list")
        }
    }
    
    func addNewNote(note: Note) {
        notes.append(note)
        saveNotes()
    }
    
    func deleteNote(note: Note) {
        let beforeCount = notes.count
        notes.removeAll { $0.id.uuidString == note.id.uuidString }
        let afterCount = notes.count
        
        print("Silme öncesi: \(beforeCount), sonrası: \(afterCount)")
        
        saveNotes()
    }
    
    func encode(object: Encodable) -> Data? {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        
        do {
            let result = try encoder.encode(object)
            return result
        } catch {
            print("Err")
        }
        
        return nil
    }
    
    func decode(_ data: Data?) -> Any? {
        return nil
    }
}
