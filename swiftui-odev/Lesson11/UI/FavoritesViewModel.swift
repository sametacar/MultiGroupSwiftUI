//
//  FavoritesViewModel.swift
//  odev_ApiVeriList
//
//  Created by vili on 25.09.2025.
//

import Foundation

@MainActor
class FavoritesViewModel: ObservableObject {
    @Published var favorites: [Character] = []
    @Published var isLoading = false
    @Published var errorMessage: String? = nil
    
    private let service: RickServiceProtocol
    
    init(service: RickServiceProtocol = RickService()) {
        self.service = service
    }
    
    func loadFavorites()  {
        favorites = FavoritesManager.shared.loadFavorites()
    }
    
    func removeFavorite(character: Character) {
        FavoritesManager.shared.removeFavorite(character: character)
        loadFavorites() // güncel listeyi al
    }
}
