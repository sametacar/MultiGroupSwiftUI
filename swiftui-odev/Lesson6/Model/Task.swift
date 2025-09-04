//
//  Task.swift
//  odev_MVVM
//
//  Created by vili on 7.09.2025.
//

import Foundation

struct Task: Identifiable, Hashable {
    var id: UUID = UUID()
    var title: String
    var isCompleted: Bool
}
