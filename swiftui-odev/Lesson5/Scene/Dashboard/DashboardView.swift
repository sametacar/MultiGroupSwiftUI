//
//  DashboardView.swift
//  AykutOn30August
//
//  Created by vili on 4.09.2025.
//

import SwiftUI

struct DashboardView: View {
    
    @StateObject var middleEarth = MiddleEarthDataOperator.shared
    @State private var newMemberName = ""
    @State private var newMemberDesc = ""
    @State private var showAddSheetForNationID: Int? = nil
    
    var body: some View {
        NavigationStack {
            List {
                Section (header: Text("Dünya")) {
                    HStack {
                        Text("Orjin:")
                        Spacer()
                        Text(middleEarth.data.tag.origin)
                    }
                    
                    HStack {
                        Text("Konu:")
                        Spacer()
                        Text(middleEarth.data.tag.focus)
                    }
                    
                    HStack {
                        Text("Zaman:")
                        Spacer()
                        Text(middleEarth.data.tag.era)
                    }
                }
                
                ForEach(middleEarth.data.people, id: \.id) { nation in
                    Section(header: Text(nation.country + " Üyeleri")) {
                        
                        ForEach(nation.members) { member in
                            NavigationLink(destination: PeopleDetailView(member: member, nation: nation)) {
                                VStack(alignment: .leading) {
                                    Text(member.name)
                                        .font(.headline)
                                }
                            }
                        }
                        
                        Button {
                            showAddSheetForNationID = nation.id
                            newMemberName = ""
                        } label: {
                            Label("\(nation.country) için Yeni Üye", systemImage: "plus.circle")
                                .foregroundColor(.green)
                        }
                    }
                }
            }
            
            .sheet(item: $showAddSheetForNationID) { nationID in
                addMemberSheet(for: nationID)
            }
        }
    }
    
    /// Sheet
    @ViewBuilder
    private func addMemberSheet(for nationID: Int) -> some View {
        VStack(spacing: 20) {
            Text("Yeni Üye Ekle")
                .font(.title2)
                .bold()
            
            TextField("Üye adı", text: $newMemberName)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            TextField("Açıklama", text: $newMemberDesc)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            HStack {
                Button("İptal") {
                    showAddSheetForNationID = nil
                }
                Spacer()
                Button("Ekle") {
                    if !newMemberName.trimmingCharacters(in: .whitespaces).isEmpty {
                        middleEarth.addMember(name: newMemberName, to: nationID, description: newMemberDesc)
                    }
                    showAddSheetForNationID = nil
                }
                .buttonStyle(.borderedProminent)
            }
            .padding(.horizontal)
        }
        .padding()
    }
}

#Preview {
    DashboardView().environmentObject(MiddleEarthDataOperator.shared)
}

// Identifiable
extension Int: Identifiable {
    public var id: Int { self }
}

