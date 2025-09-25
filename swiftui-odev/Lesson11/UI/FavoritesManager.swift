//
//  FavoritesManager.swift
//  odev_ApiVeriList
//
//  Created by vili on 25.09.2025.
//

import Foundation

final class FavoritesManager: ObservableObject {
    private let key = "favoriteCharacters"
    private let defaults = UserDefaults.standard
    @Published var favorites: [Character] = []
    
    static let shared = FavoritesManager()
    private init() {}
    
    // Favori ID’lerini getir
    func loadFavorites() -> [Character] {
        if let data = defaults.data(forKey: key),
               let decoded = try? JSONDecoder().decode([Character].self, from: data) {
                favorites = decoded
            } else {
                favorites = []
            }
            return favorites
    }
    
    // Favoriye ekle
    func addFavorite(character: Character) {
        if !favorites.contains(where: { $0.id == character.id }) {
            favorites.append(character)
            saveFavorites()
        }
    }
    
    // Favoriden çıkar
    func removeFavorite(character: Character) {
        favorites.removeAll { $0.id == character.id }
        saveFavorites()
    }
    
    // Favori mi?
    func isFavorite(character: Character) -> Bool {
        favorites.contains(where: { $0.id == character.id })
    }
    
    func saveFavorites() {
    if let data = try? JSONEncoder().encode(favorites) {
        defaults.set(data, forKey: key)
    }
}
}
