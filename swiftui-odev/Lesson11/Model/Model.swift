//
//  Model.swift
//  odev_ApiVeri
//
//  Created by vili on 21.09.2025.
//


import Foundation

struct RickResponse: Codable {
    var info: RequestInfo
    var results: [Character]
}

struct RequestInfo: Codable {
    var count: Int
    var pages: Int
    var next: String? // link
    var prev: String? // link
}

struct Character: Codable, Identifiable {
    var id: Int
    var name: String
    var status: String
    var species: String
    var type: String
    var gender: String
    var origin: NameUrlModel
    var location: NameUrlModel
    var image: String
    var episode: [String]
    var url: String
    var created: String?
}

struct NameUrlModel: Codable {
    var name: String
    var url: String
}
