//
//  CharacterRowView.swift
//  odev_ApiVeriList
//
//  Created by vili on 25.09.2025.
//

import SwiftUI

struct CharacterRowView: View {
    let character: Character
        @ObservedObject var favorites = FavoritesManager.shared
        
        var body: some View {
            HStack {
                if let url = URL(string: character.image) {
                    AsyncImage(url: url) { image in
                        image.resizable()
                            .scaledToFit()
                            .frame(width: 50, height: 50)
                    } placeholder: {
                        ProgressView()
                    }
                }
                
                Text(character.name.capitalized)
                
                Spacer()
                
                Button {
                    if favorites.isFavorite(character: character) {
                        favorites.removeFavorite(character: character)
                    } else {
                        favorites.addFavorite(character: character)
                    }
                } label: {
                    Image(systemName: favorites.isFavorite(character: character) ? "heart.fill" : "heart")
                        .foregroundColor(.red)
                }
                .buttonStyle(.plain)
            }
        }
}

#Preview {
    CharacterRowView(
        character: Character(
            id: 1,
            name: "Rick Sanchez",
            status: "Alive",
            species: "Human",
            type: "",
            gender: "Male",
            origin: NameUrlModel(name: "Earth", url: "https://rickandmortyapi.com/api/location/1"),
            location: NameUrlModel(name: "Earth", url: "https://rickandmortyapi.com/api/location/20"),
            image: "https://rickandmortyapi.com/api/character/avatar/1.jpeg",
            episode: ["https://rickandmortyapi.com/api/episode/1"],
            url: "https://rickandmortyapi.com/api/character/1",
            created: nil
        )
    )
}
