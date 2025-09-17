//
//  ContentView.swift
//  odev_coreData
//
//  Created by vili on 16.09.2025.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = ContentViewModel()
    @State private var searchText: String = ""
    
    var body: some View {
        let list = viewModel.notes
        
        let filteredList = viewModel.notes.filter { note in
            searchText.isEmpty || note.title.localizedCaseInsensitiveContains(searchText)
        }
        
        NavigationStack {
            
            // SearchBox
            if !list.isEmpty {
                TextField("Ara...", text: $searchText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)
            }
            
            List {
                if !filteredList.isEmpty {
                    ForEach(filteredList, id: \.id) { item in
                        NavigationLink(destination: NoteView(viewModel: viewModel, note: item)) {
                            VStack(alignment: .leading) {
                                Text(item.title)
                                Text(item.date.formatted(date: .abbreviated, time: .omitted))
                                    .foregroundColor(.secondary)
                            }
                        }
                    } //: foreach
                    .onDelete { indexSet in
                        indexSet.forEach { index in
                            let id = filteredList[index].id
                            viewModel.deleteNote(id: id)
                        }
                    } //: onDelete
                }
                
                if filteredList.isEmpty && !list.isEmpty {
                    Text("Sonuç bulunamadı.")
                        .foregroundColor(.secondary)
                }
            } //: List
            .padding(.top, 10)
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
        } //: ScreenCover
    }
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
        @State private var content: String = ""
        
        var body: some View {
            NavigationStack {
                Form {
                    Section("Yeni Not Giriniz") {
                        TextField("Başlık", text: $title)
                        ZStack(alignment: .topLeading) {
                            if content.isEmpty {
                                Text("Detay giriniz…")
                                    .foregroundColor(.gray.opacity(0.6))
                                    .padding(.horizontal, 5)
                                    .padding(.vertical, 8)
                            }
                            
                            TextEditor(text: $content)
                                .frame(height: 150)
                                .padding(4)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                                )
                            }
                    } // Section
                    
                    Button() {
                        viewModel.addNewNote(title: title, content: content)
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
              
            } //: NavigationStack
        } //: body
    }
}
