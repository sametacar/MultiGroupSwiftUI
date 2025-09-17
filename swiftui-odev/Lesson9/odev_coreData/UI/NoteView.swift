//
//  EventDetailView.swift
//  odev_formsModels
//
//  Created by vili on 11.09.2025.
//

import SwiftUI

struct NoteView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var viewModel: ContentViewModel
    
    // Note comes from navigationLink
    var note: Note
        
    @State private var title: String
    @State private var content: String
    
    init(viewModel: ContentViewModel, note: Note) {
       self.viewModel = viewModel
       self.note = note
       _title = State(initialValue: note.title)
       _content = State(initialValue: note.content)
    }
        
    var body: some View {
        Form {
            Section("Not Detayı") {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Başlık")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    TextField("Başlık", text: $title)
                        .textFieldStyle(.roundedBorder)
                }
                
                HStack {
                    Text("Tarih")
                        .foregroundColor(.secondary)
                    Spacer()
                    Text(note.date.formatted(date: .abbreviated, time: .shortened))
                        .foregroundColor(.secondary)
                }
                
                VStack(alignment: .leading, spacing: 4) {
                    Text("Detay")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    TextEditor(text: $content)
                        .frame(height: 150)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                        )
                }
            } //: Section
            
            Button {
                let updatedNote = Note(
                    id: note.id,  // keep value
                    title: title,
                    content: content,
                    date: note.date // keep value
                )
                viewModel.updateNote(note: updatedNote)
                dismiss()
            } label: {
                Label("Notu Güncelle", systemImage: "square.and.pencil")
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(.blue)
                    .cornerRadius(8)
            }
            .listRowBackground(Color.clear)
            .frame(maxWidth: .infinity)
            
            Button() {
                viewModel.deleteNote(id: note.id)
                dismiss()
            } label :  {
                Label("Notu Sil", systemImage: "trash")
                .font(.system(size: 18, weight: .bold))
               .foregroundColor(.white)
               .padding()
               .frame(maxWidth: .infinity)
               .background(.red)
               .cornerRadius(8)
              
            }
            .listRowBackground(Color.clear)
            .frame(maxWidth: .infinity)
        } //: form
        .toolbar {
            ToolbarItem(placement: .cancellationAction) {
                Button("İptal") { dismiss() }
            }
        } //: toolbar
    } //: body
}

#Preview {
    NoteView(
       viewModel: ContentViewModel(),
       note: Note(
            id: UUID(),
            title: "not başlığı",
            content: "",
            date: Date()
        )
    )
}
