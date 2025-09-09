//
//  Event.swift
//  odev_formsModels
//
//  Created by vili on 10.09.2025.
//

import Foundation

struct Event: Identifiable, Hashable {
    var id: UUID = UUID()
    var title: String
    var date: Date
    var type: EventType
    var hasReminder: Bool
    
}

enum EventType: String, CaseIterable, Identifiable {
    case birthday = "Doğum Günü"
    case meeting = "Toplantı"
    case holiday = "Tatil"
    case sport = "Spor"
    case other = "Diğer"
    
    var id: String {self.rawValue}
    var displayName: String {self.rawValue}
}
