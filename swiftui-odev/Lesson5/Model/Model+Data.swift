//
//  Model+Data.swift
//  AykutOn30August
//
//  Created by vili on 2.09.2025.
//

import Foundation
import Combine

final class MiddleEarthDataOperator: ObservableObject {
    
    static let shared = MiddleEarthDataOperator()
    
    @Published private(set) var data: MiddleEarthModel
    
    private init() {
        self.data = Self.loadFromBundle("data.json")
    }
    
    private static func loadFromBundle(_ filename: String) -> MiddleEarthModel {
        guard let url = Bundle.main.url(forResource: filename, withExtension: nil) else {
            fatalError("Dosya bulunamadı: \(filename)")
        }

        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            return try decoder.decode(MiddleEarthModel.self, from: data)
        } catch {
            fatalError("JSON parse hatası: \(error)")
        }
    }
    
    // Ülkeye yeni üye ekle
    func addMember(name: String, to nationID: Int, description: String = "") {
        var model = data
        guard let idx = model.people.firstIndex(where: { $0.id == nationID }) else { return }
        let nextID = (model.people[idx].members.map { $0.id }.max() ?? 0) + 1
        let newMember = PeopleModel(id: nextID, name: name, description: description)
        model.people[idx].members.append(newMember)
        data = model // @Published tetiklensin
    }
}
