//
//  ContentViewModel.swift
//  odev_MVVM
//
//  Created by vili on 7.09.2025.
//

import Foundation

class ContentViewModel: ObservableObject {
 
    //: MARK: - Properties
    /// List Variable for tasks
    @Published var tasks: [Task] = []
    /// Controls whether an alert should be displayed
    @Published var isAlertShowing: Bool = false
    /// Task title for new Task
    @Published var newTaskTitle: String = ""
    
    // Mark: - Methods
    
    func addTask(title: String) {
        
        // Prevent adding empty wish
        guard !title.isEmpty else { return }
        
        // Create new Task
        let Task = Task(id: UUID(), title: title, isCompleted: false)
        tasks.append(Task)
        // unfill New Task Title
        newTaskTitle = ""
    }
    
    /// Remove a task  (ödevde, .onDelte kullansılsın dediği için bunu swiğe actionsta kullanmaktan vazgeçtim)
    /// - Parameter id: guid of task
    func removeTask(id: UUID) {
        if let index = tasks.firstIndex(where: { $0.id == id }) {
                tasks.remove(at: index)
            }
    }
}
