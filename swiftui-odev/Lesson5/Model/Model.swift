//
//  SwiftUIView.swift
//  AykutOn30August
//
//  Created by vili on 2.09.2025.
//

import Foundation

struct MiddleEarthModel: Codable {
    let tag: TagModel
    var people: [FolksModel]
}

struct TagModel: Codable {
    let origin: String
    let focus: String
    let era: String
}

struct FolksModel: Codable {
    let country: String
    let capital: String
    let id: Int
    let isActive: Bool
    var members: [PeopleModel]
}

struct PeopleModel: Codable, Identifiable {
    let id: Int
    let name: String
    let description: String
}
