//
//  EventDetailView.swift
//  odev_formsModels
//
//  Created by vili on 11.09.2025.
//

import SwiftUI

struct NoteView: View {
   // @StateObject var viewModel = ContentViewModel()
    @Environment(\.dismiss) var dismiss
    @ObservedObject var viewModel: ContentViewModel
    
    var note: Note
    
    var body: some View {
        Form {
            Section("Not Detayı") {
                HStack {
                    Text("Not Başlığı")
                    Spacer()
                    Text(note.title)
                    .foregroundColor(.secondary)
                }
                
                HStack {
                    Text("Tarih")
                    Spacer()
                    Text(note.date.formatted(date: .abbreviated, time: .shortened))
                        .foregroundColor(.secondary)
                }
                
                HStack {
                    Text("Detay")
                    Spacer()
                    Text(note.content)
                    .foregroundColor(.secondary)
                }
                   
            } //: Section
            
            Button() {
                viewModel.deleteNote(note: note)
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
        }
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
