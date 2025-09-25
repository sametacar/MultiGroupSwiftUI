//
//  ContentViewModel.swift
//  odev_ApiVeriList
//
//  Created by vili on 24.09.2025.
//

import Foundation

class ContentViewModel: ObservableObject {
    //: Mark - Properties
    @Published var characters: [Character] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil
    private var currentPage = 1
    private var canLoadMore = true
    private var currentQuery: String? = nil
    
    
    private let service: RickServiceProtocol
    
    init(service: RickServiceProtocol = RickService()) {
        self.service = service
    }
    
    func fetchRickCharacters(page: Int = 1, query: String? = nil) {
        Task {
            isLoading = true
            errorMessage = nil
            do {
                let result = try await service.fetchRick(query: query, page: page)
                if page == 1 {
                    self.characters = result.results
                } else {
                    self.characters.append(contentsOf: result.results)
                }
                self.currentPage = page
                self.currentQuery = query
            } catch {
                self.errorMessage = error.localizedDescription
            }
            isLoading = false
        }
    }
    
    func loadMore(currentItem: Character) {
        guard let last = characters.last else { return }
        if currentItem.id == last.id && !isLoading {
            fetchRickCharacters(page: currentPage + 1, query: currentQuery)
        }
    }
    
    func search(name: String) {
        fetchRickCharacters(page: 1, query: name)
    }
}
