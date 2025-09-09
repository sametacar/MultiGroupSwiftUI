//
//  ContentViewModel.swift
//  odev_formsModels
//
//  Created by vili on 10.09.2025.
//

import Foundation

class ContentViewModel: ObservableObject {
    //: MARK - Properties
    /// List variable for events
    @Published var events: [Event] = []
    
    @Published var showAddEventSheet: Bool = false
    
    // MARK - Methods
    
    func pushAddEventButton() {
        showAddEventSheet.toggle()
    }
    
    /// Add new Event to Event List
    /// - Parameter event: Event model
    func addNewEvent(event: Event) {
        /// check event name is empty
        if event.title.isEmpty {
            return
        }
        
        // add new event to events
        events.append(event)
        
        print(events)
    }
    
    
    /// removes an Event from Event List
    /// - Parameter event: <#event description#>
    func deleteEvent(event: Event) {
        print(events)
        events.removeAll { $0.id == event.id }
        
        print(events)
    }
}
