//
//  ContentView.swift
//  odev_ApiVeriList
//
//  Created by vili on 24.09.2025.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = ContentViewModel()
    @State private var searchText = ""

    var body: some View {
        NavigationStack {
            Group {
                if viewModel.isLoading && viewModel.characters.isEmpty {
                    ProgressView("Yükleniyor...")
                        .padding()
                } else if let error = viewModel.errorMessage {
                    VStack {
                        Text("Hata: \(error)")
                            .foregroundColor(.red)
                            .padding()
                        
                        Button("Tekrar Dene") {
                            viewModel.fetchRickCharacters(page: 1)
                        }
                        .buttonStyle(.borderedProminent)
                    }
                } else {
                    List(viewModel.characters) { c in
                        NavigationLink(destination: CharacterDetailView(character: c)) {
                            CharacterRowView(character: c)
                        }
                        .onAppear {
                            viewModel.loadMore(currentItem: c)
                        }
                    } //: List
                    // Pull to refresh
                    .refreshable {
                        viewModel.fetchRickCharacters(page: 1, query: "")
                    }
                }
            } //: Group
            .navigationTitle("R n'M Karakterleri")
            .searchable(text: $searchText, prompt: "Karakter ara")
               .onSubmit(of: .search) {
                   viewModel.search(name: searchText)
               }
            .onAppear {
                if viewModel.characters.isEmpty {
                    viewModel.fetchRickCharacters(page: 1)
                }
            }
        } //: NavigationStack
    }
}

#Preview {
    ContentView()
}
