//
//  ContentViewModel.swift
//  odev_ApiVeri
//
//  Created by vili on 21.09.2025.
//

import Foundation

class ContentViewModel: ObservableObject {
    //: Mark - Properties
    @Published var pokemons: [Pokemon] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil
    
    private let service: PokemonServiceProtocol
    
    init(service: PokemonServiceProtocol = PokemonService()) {
        self.service = service
    }
    
    func fetchPokemons(page: Int = 1, pageSize: Int = 40) {
        Task {
            isLoading = true
            errorMessage = nil
            do {
                let result = try await service.fetchPokemon(query: nil, page: page, pageSize: pageSize)
                self.pokemons = result
            } catch {
                self.errorMessage = error.localizedDescription
            }
            isLoading = false
        }
    }
}
