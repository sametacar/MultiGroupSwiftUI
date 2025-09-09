//
//  EventDetailView.swift
//  odev_formsModels
//
//  Created by vili on 11.09.2025.
//

import SwiftUI

struct EventDetailView: View {
   // @StateObject var viewModel = ContentViewModel()
    @Environment(\.dismiss) var dismiss
    @ObservedObject var viewModel: ContentViewModel
    
    var event: Event
    
    var body: some View {
        Form {
            Section("Etkinlik Bilgileri") {
                HStack {
                        Text("Adı")
                        Spacer()
                        Text(event.title)
                            .foregroundColor(.secondary)
                    }
                    HStack {
                        Text("Tarih")
                        Spacer()
                        Text(event.date.formatted(date: .abbreviated, time: .shortened))
                            .foregroundColor(.secondary)
                    }
                    HStack {
                        Text("Tür")
                        Spacer()
                        Text(event.type.displayName)
                            .foregroundColor(.secondary)
                    }
                    HStack {
                        Text("Hatırlatma")
                        Spacer()
                        Text(event.hasReminder ? "Açık" : "Kapalı")
                            .foregroundColor(.secondary)
                    }
            } //: Section
            
            Button() {
                viewModel.deleteEvent(event: event)
                dismiss()
            } label :  {
                Label("Etkinliği Sil", systemImage: "trash")
                .font(.system(size: 18, weight: .bold))
               .foregroundColor(.white)
               .padding()
               .frame(maxWidth: .infinity)
               .background(.red)
               .cornerRadius(8)
              
            }
            .listRowBackground(Color.clear)
            .frame(maxWidth: .infinity)
        }
        .navigationTitle("Etkinlik Detayı")
    } //: body
}

#Preview {
    EventDetailView(
        viewModel: ContentViewModel(),
       event: Event(
            title: "Test Etkinliği",
            date: Date(),
            type: .meeting,
            hasReminder: false
        )
    )
}
