//
//  PeopleDetailView.swift
//  AykutOn30August
//
//  Created by vili on 4.09.2025.
//

import SwiftUI

struct PeopleDetailView: View {
    @State private var showAddAlertForNationID: Int? = nil
    @State private var newMemberName: String = ""
    
    var member: PeopleModel
    var nation: FolksModel
    
    var body: some View {
        List {
            Section(header: Text("Üye Künyesi")){
                HStack(spacing: 5) {
                    Text("İsim")
                    Spacer()
                    Text(member.name)
                        .foregroundColor(.blue)
                }
                
                HStack(spacing: 5) {
                    Text("Numarası")
                    Spacer()
                    Text("\(member.id)")
                        .foregroundColor(.blue)
                }
                
                HStack(spacing: 2) {
                    Text("Ülke")
                    Spacer()
                    Text(nation.country)
                        .foregroundColor(.blue)
                }
                
                HStack(spacing: 2) {
                    Text("Başkent")
                    Spacer()
                    Text(nation.capital)
                        .foregroundColor(.blue)
                }
                VStack(alignment: .leading,spacing: 0) {
                    Text("Açıklama:")
                    Spacer()
                    Text(member.description)
                        
                }
                .padding(.vertical, 14)
            }
            
        }
    }
}

#Preview {
    
    let sampleMember = PeopleModel(
            id: 1,
            name: "Boromir",
            description: "Gondor na-vekilharcı, prens"
        )
    
    let sampleNation = FolksModel(
           country: "Gondor",
           capital: "Minas Trith",
           id: 10001,
           isActive: true,
           members: [sampleMember]
       )
    
    
    PeopleDetailView(
            member: sampleMember,
            nation: sampleNation
        )
}
