//
//  Model.swift
//  odev_ApiVeri
//
//  Created by vili on 21.09.2025.
//


import Foundation

struct PokemonResponse: Codable {
    let count: Int
    let next: String?
    let previous: String?
    let results: [Pokemon]
}

struct Pokemon: Codable, Identifiable {
    var name: String
    var url: String
    
    var id: Int {
        extractId() ?? 0
    }
    
    var imageUrl: String? {
        guard let pokemonId = extractId() else { return nil }
        return "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/\(pokemonId).png"
    }
 
    func extractId() -> Int? {
       // URL’nin sonundaki boş component’leri atıyoruz
       let components = url.split(separator: "/").compactMap { Int($0) }
       return components.last
   }
}
