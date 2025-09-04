//
//  AykutOn30AugustApp.swift
//  AykutOn30August
//
//  Created by vili on 2.09.2025.
//

import SwiftUI

//@main
struct AykutOn30AugustApp: App {
    var body: some Scene {
        WindowGroup {
            DashboardView().environmentObject(MiddleEarthDataOperator.shared)
        }
    }
}
