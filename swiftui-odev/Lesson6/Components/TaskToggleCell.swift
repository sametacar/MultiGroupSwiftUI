//
//  TaskToggleCell.swift
//  odev_MVVM
//
//  Created by vili on 8.09.2025.
//

import SwiftUI

struct TaskToggleCell: View {
    
    // Properties
    @Binding var task: Task
    
    // MARK: - Body
    var body: some View {
        Toggle(isOn: $task.isCompleted) {
                        Text(task.title)
                    }
                
    }
}

