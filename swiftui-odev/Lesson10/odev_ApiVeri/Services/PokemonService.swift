//
//  PokemonService.swift
//  odev_ApiVeri
//
//  Created by vili on 21.09.2025.
//

import Foundation
import BuddiesNetwork

enum PokemonServiceError: LocalizedError {
    case clientUnavailable

    var errorDescription: String? {
        switch self {
        case .clientUnavailable:
            return "API client hazır değil."
        }
    }
}

protocol PokemonServiceProtocol {
    func fetchPokemon(query: String?, page: Int, pageSize: Int) async throws -> [Pokemon]
}

final class PokemonService: PokemonServiceProtocol {
    private let apiClient: PokemonApiClient?
        
    // init metodunu güncelliyoruz
    init(apiClient: PokemonApiClient? = PokemonApiClient.shared) {
        self.apiClient = apiClient
    }
    
    func fetchPokemon(query: String?, page: Int, pageSize: Int) async throws -> [Pokemon] {
        guard let apiClient = apiClient else {
            throw PokemonServiceError.clientUnavailable
        }

        let offset = (page - 1) * pageSize
        let request = FetchPokemonRequest(limit: pageSize, offset: offset)

        do {
            let response = try await apiClient.perform(request)
            return response.results
        } catch {
            throw error
        }
    }
}


// API Request - Get Pokemon List
struct FetchPokemonRequest: Requestable {
    typealias Data = PokemonResponse
        
    let limit: Int
    let offset: Int
    
    func httpProperties() -> HTTPOperation<Self>.HTTPProperties {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "pokeapi.co"
        components.path = "/api/v2/pokemon"
        components.queryItems = [
            URLQueryItem(name: "limit", value: String(limit)),
            URLQueryItem(name: "offset", value: String(offset))
        ]
        
        guard let url = components.url else {
            fatalError("Geçersiz URL oluşturuldu: \(components)")
        }
        
        return .init(
            url: url,
            httpMethod: .get,
            additionalHeaders: [:],
            data: nil
        )
    }
}
