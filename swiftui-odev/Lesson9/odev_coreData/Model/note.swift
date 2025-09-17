//
//  note.swift
//  odev_userDefaults
//
//  Created by vili on 12.09.2025.
//

import Foundation

struct Note: Identifiable {
    let id: UUID
    var title: String
    var content: String
    var date: Date
}
