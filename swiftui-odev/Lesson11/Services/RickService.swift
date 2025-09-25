//
//  RickService.swift
//  odev_ApiVeriList
//
//  Created by vili on 24.09.2025.
//

import Foundation
import BuddiesNetwork

enum RickServiceError: LocalizedError {
    case clientUnavailable

    var errorDescription: String? {
        switch self {
        case .clientUnavailable:
            return "API client hazır değil."
        }
    }
}

protocol RickServiceProtocol {
    func fetchRick(query: String?, page: Int) async throws -> RickResponse
    func fetchCharactersByIds(_ ids: [Int]) async throws -> [Character]
}

final class RickService: RickServiceProtocol {
    private let apiClient: RickApiClient?
    
    init(apiClient: RickApiClient? = RickApiClient.shared) {
        self.apiClient = apiClient
    }
    
    private let baseURL = "https://rickandmortyapi.com/api/character"
    
    func fetchRick(query: String?, page: Int = 1) async throws -> RickResponse {
        var urlComponents = URLComponents(string: baseURL)!
        var queryItems = [URLQueryItem(name: "page", value: "\(page)")]
        
        if let query = query, !query.isEmpty {
            queryItems.append(URLQueryItem(name: "name", value: query))
        }
        
        urlComponents.queryItems = queryItems
        
        guard let url = urlComponents.url else {
            throw URLError(.badURL)
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return try decoder.decode(RickResponse.self, from: data)
    }
    
    func fetchCharactersByIds(_ ids: [Int]) async throws -> [Character] {
        guard !ids.isEmpty else { return [] }
        
        // ID’leri virgül ile birleştiriyoruz
        let idsString = ids.map { String($0) }.joined(separator: ",")
        let urlString = "\(baseURL)/\(idsString)"
        
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        // Eğer tek ID varsa JSON obje döner, birden fazla ID varsa array döner
        if ids.count == 1 {
            let character = try decoder.decode(Character.self, from: data)
            return [character]
        } else {
            return try decoder.decode([Character].self, from: data)
        }
    }
}

// API Request - Get RickCharacter List
struct FetchRickRequest: Requestable {
    typealias Data = RickResponse
        
    let page: Int
    let query: String?
    
    func httpProperties() -> HTTPOperation<Self>.HTTPProperties {
        var components = URLComponents()
            components.scheme = "https"
            components.host = "rickandmortyapi.com"
            components.path = "/api/character"
            
            var items = [URLQueryItem(name: "page", value: String(page))]
            if let query, !query.isEmpty {
                items.append(URLQueryItem(name: "name", value: query))
            }
            components.queryItems = items
            
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
    
    func transform(_ data: RickResponse) -> [Character] {
        data.results
    }
}
