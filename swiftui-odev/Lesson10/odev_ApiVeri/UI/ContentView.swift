//
//  ContentView.swift
//  odev_ApiVeri
//
//  Created by vili on 21.09.2025.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = ContentViewModel()
    @State private var searchText: String = ""
    
    var body: some View {
        let list = viewModel.pokemons
        
        let filteredList = viewModel.pokemons.filter { pokemon in
            searchText.isEmpty || pokemon.name.localizedCaseInsensitiveContains(searchText)
        }
        
        NavigationStack {
            Group {
                if viewModel.isLoading {
                    ProgressView("Loading...")
                } else if let error = viewModel.errorMessage {
                    Text("Error: \(error)")
                        .foregroundColor(.red)
                        .padding()
                } else if viewModel.pokemons.isEmpty {
                    Text("Henüz Pokémon listesi yok.")
                        .foregroundColor(.gray)
                        .padding()
                } else {
                    // SearchBox
                    if !list.isEmpty {
                        TextField("Pokemon ara...", text: $searchText)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding(.horizontal)
                    }
                    
                    // liste
                    List(filteredList) { pokemon in
                        HStack {
                            if let imageUrl = pokemon.imageUrl,
                               let url = URL(string: imageUrl) {
                                AsyncImage(url: url) { image in
                                    image.resizable()
                                        .scaledToFit()
                                        .frame(width: 50, height: 50)
                                } placeholder: {
                                    ProgressView()
                                }
                            }
                            Text(pokemon.name.capitalized)
                        } //: HStack
                    } //: List
                    
                    if filteredList.isEmpty && !list.isEmpty {
                        Text("Sonuç bulunamadı")
                    }
                }
            }
            .navigationTitle("Pokemonlar")
            .onAppear {
                if list.isEmpty {
                    viewModel.fetchPokemons()
                }
            }
        } //: NavigationStack
    } //: Body
}

#Preview {
    ContentView()
}
