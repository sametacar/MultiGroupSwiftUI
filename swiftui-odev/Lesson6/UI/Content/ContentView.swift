//
//  ContentView.swift
//  odev_MVVM
//
//  Created by vili on 7.09.2025.
//

import SwiftUI

struct ContentView: View {
    // MARK: - Properties
    @StateObject var viewModel = ContentViewModel()
    
    // MARK: - Body
    var body: some View {
        
        NavigationStack {
            List() {
                 ForEach($viewModel.tasks) { $task in
                    TaskToggleCell(task: $task)
                }
                .onDelete { indexSet in
                    viewModel.tasks.remove(atOffsets: indexSet)
                }
            } //: List
            .navigationTitle(Localizations.contentViewTitle)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    addButton()
                }
            } //: toolbar
        } //: NavigationStack
        
        .overlay {
            if viewModel.tasks.isEmpty {
                ContentUnavailableView("Task List is Empty", systemImage: "tray")
                    .foregroundColor(.purple)
            }
        } //: overlay
        
        .alert("Add a Task", isPresented: $viewModel.isAlertShowing) {
            TextField("Enter task here", text: $viewModel.newTaskTitle)
            
            Button("Add") {
                viewModel.addTask(title: viewModel.newTaskTitle)
            }
        } //: alert
    } //: body
} //: ContentView View

// MARK: - Preview
#Preview {
    ContentView()
}

// MARK: - Extension
extension ContentView {
    
    @ViewBuilder
    func addButton() -> some View {
        Button {
            viewModel.isAlertShowing.toggle()
        } label: {
            Image(systemName: "plus")
        }
    }
}
