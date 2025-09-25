//
//  CharacterDetailView.swift
//  odev_ApiVeriList
//
//  Created by vili on 24.09.2025.
//

import SwiftUI

struct CharacterDetailView: View {
    let character: Character
    @State private var isFavorite: Bool = false
    
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                if let url = URL(string: character.image) {
                    AsyncImage(url: url) { image in
                        image
                            .resizable()
                            .scaledToFit()
                            .frame(width: 200, height: 200)
                            .clipShape(Circle())
                            .shadow(radius: 8)
                    } placeholder: {
                        ProgressView()
                    }
                }
                
                Text(character.name)
                    .font(.title)
                    .bold()
                
                // Alt alta bilgiler
                VStack(alignment: .leading, spacing: 8) {
                    Text("Species: \(character.species)")
                    if !character.type.isEmpty {
                        Text("Type: \(character.type)")
                    }
                    Text("Gender: \(character.gender)")
                    Text("Origin: \(character.origin.name)")
                    Text("Location: \(character.location.name)")
                }
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color.gray.opacity(0.1))
                .cornerRadius(12)
                
                Button {
                    if FavoritesManager.shared.isFavorite(character: character) {
                        FavoritesManager.shared.removeFavorite(character: character)
                    } else {
                        FavoritesManager.shared.addFavorite(character: character)
                    }
                    isFavorite.toggle()
                } label: {
                    Label(isFavorite ? "Favoriden Çıkar" : "Favoriye Ekle",
                          systemImage: isFavorite ? "star.fill" : "star")
                }
                .buttonStyle(.borderedProminent)
                .padding()
            }
            .padding()
            .navigationTitle(character.name)
            .navigationBarTitleDisplayMode(.inline)
        }
        .onAppear {
            isFavorite = FavoritesManager.shared.isFavorite(character: character)
        }
    }
}


#Preview {
CharacterDetailView(
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
