//
//  FavoritesView.swift
//  odev_ApiVeriList
//
//  Created by vili on 24.09.2025.
//
import SwiftUI

struct FavoritesView: View {
    @State private var favorites: [Character] = []
    @StateObject private var viewModel = FavoritesViewModel()

    var body: some View {
        NavigationStack {
            Group {
                if viewModel.favorites.isEmpty {
                    VStack {
                        Image(systemName: "star.slash.fill")
                            .font(.system(size: 50))
                            .foregroundColor(.gray)
                            .padding(.bottom, 8)
                        Text("Henüz favori karakter yok")
                            .foregroundColor(.gray)
                    }
                } else {
                    List(viewModel.favorites, id: \.id) { character in
                        NavigationLink(destination: CharacterDetailView(character: character)) {
                            HStack {
                                AsyncImage(url: URL(string: character.image)) { image in
                                    image
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 60, height: 60)
                                        .clipShape(Circle())
                                } placeholder: {
                                    ProgressView()
                                }
                                .padding(.trailing, 8)

                                VStack(alignment: .leading) {
                                    Text(character.name)
                                        .font(.headline)
                                    Text(character.species)
                                        .font(.subheadline)
                                        .foregroundColor(.secondary)
                                }
                            }
                            .padding(.vertical, 4)
                        }
                    }
                }
            }
            .navigationTitle("Favoriler")
            .task {
                viewModel.loadFavorites()
            }
        }
    }
}

#Preview {
    FavoritesView()
}
