//
//  ContentView.swift
//  odev_formsModels
//
//  Created by vili on 10.09.2025.
//

import SwiftUI

struct ContentView: View {
    // MARK - Properties
    @StateObject var viewModel = ContentViewModel()
    
    var body: some View {
        NavigationStack {
            List() {
                ForEach(viewModel.events) { event in
                    NavigationLink {
                        EventDetailView(viewModel: viewModel, event: event)
                    } label : {
                        Text(event.title)
                    }
                } //: foreach
            } //: List
            .navigationTitle("Etkinliklerim")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                                viewModel.pushAddEventButton()
                            }) {
                                Image(systemName: "plus")
                            }
                } //: ToolbarItem
            } //: toolbar
        } //: Navigatiostack
        
        .overlay {
            if viewModel.events.isEmpty {
                ContentUnavailableView("Etkinlik listeniz boş", systemImage: "tray")
            }
        } //: overlay
        
        .sheet(isPresented: $viewModel.showAddEventSheet) {
            AddEventView(viewModel: viewModel)
                .presentationDetents([.fraction(0.6), .large])
                .environmentObject(viewModel)
        } //: sheet
    } //: body
}

#Preview {
    ContentView()
}

// MARK: Extension
extension ContentView {
    
    struct AddEventView: View {
       
        @Environment(\.dismiss) var dismiss
        //@StateObject var viewModel = ContentViewModel()
        @ObservedObject var viewModel: ContentViewModel
        
        
        @State private var title: String = ""
        @State private var date: Date = Date()
        @State private var type: EventType = .other
        @State private var hasReminder: Bool = false
        
        var body: some View {
            NavigationStack {
                Form {
                    Section("Etkinlik Bilgileri") {
                        TextField("Başlık", text: $title)
                        
                        DatePicker("Tarih", selection: $date, displayedComponents: [.date, .hourAndMinute])
                        
                        Picker("Tür", selection: $type) {
                            ForEach(EventType.allCases) { t in
                                Text(t.displayName).tag(t)
                            }
                        }
                        
                        Toggle("Hatırlatma", isOn: $hasReminder)
                    } // Section
                    
                    Button() {
                        let event = Event(
                            title: title,
                            date: date,
                            type: type,
                            hasReminder: hasReminder
                        )
                        
                        viewModel.addNewEvent(event: event)
                        dismiss()
                    } label : {
                        Text("Kaydet")
                        .foregroundColor(.white)
                       .padding()
                       .frame(maxWidth: .infinity)
                       .background(.green)
                       .cornerRadius(8)
                    }
                    .listRowBackground(Color.clear)
                    .frame(maxWidth: .infinity)
                } //: Form
                
                .toolbar {
                    ToolbarItem(placement: .cancellationAction) {
                        Button("İptal") { dismiss() }
                    }
                } //: toolbar
            } //: NavigationStack
        } //: body
    }
}
