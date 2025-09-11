//
//  ContentView.swift
//  odev_userDefaults
//
//  Created by vili on 12.09.2025.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = ContentViewModel()
    
    var body: some View {
        //let list = viewModel.getNotes(forKey: "list") ?? []
        let list = viewModel.notes
        NavigationStack {
            List {
                if !list.isEmpty {
                    ForEach(list, id: \.id) { item in
                        NavigationLink(destination: NoteView(viewModel: viewModel, note: item)) {
                                Text(item.title)
                            }
                    } //: foreach
                }
            } //: List
            .navigationTitle("Notlarım")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                            viewModel.pushAddNoteButton()
                        } label: {
                            Image(systemName: "plus")
                        }
                } //: ToolbarItem
            } //: toolbar
            
            if list.isEmpty {
                Text("Not listeniz boş.")
            }
        } //: NavigationStack
        
        .fullScreenCover(isPresented: $viewModel.showAddCover) {
            AddNoteView(viewModel: viewModel)
        }
    } //: body
}

#Preview {
    ContentView()
}

// MARK: Extension
extension ContentView {
    struct AddNoteView: View {
        
        @ObservedObject var viewModel: ContentViewModel
        @Environment(\.dismiss) var dismiss
        
        @State private var title: String = ""
        @State private var date: Date = Date()
        @State private var content: String = ""
        
        var body: some View {
            NavigationStack {
                Form {
                    Section("Not Giriniz") {
                        TextField("Başlık", text: $title)
                        
                        DatePicker("Tarih", selection: $date, displayedComponents: [.date, .hourAndMinute])
                        
                        TextField("Detay", text: $content)
                    } // Section
                    
                    Button() {
                        let newNote = Note(
                            id: UUID(),
                            title: title,
                            content: content,
                            date: date
                        )
                        
                        viewModel.addNewNote(note: newNote)
                        dismiss()
                    } label : {
                        Text("Kaydet")
                        .foregroundColor(.white)
                       .padding()
                       .frame(maxWidth: .infinity)
                       .background(.green)
                       .cornerRadius(8)
                    }
                    .listRowBackground(Color.clear)
                    .frame(maxWidth: .infinity)
                } //: Form
                .toolbar {
                    ToolbarItem(placement: .cancellationAction) {
                        Button("İptal") { dismiss() }
                    }
                } //: toolbar
            } //: NavigationStack
        } //: body
    }
}
