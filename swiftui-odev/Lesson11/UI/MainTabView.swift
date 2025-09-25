//
//  TabView.swift
//  odev_ApiVeriList
//
//  Created by vili on 24.09.2025.
//

import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
           ContentView()
                .tabItem {
                    Label("Karakterler", systemImage: "person.3.fill")
                }

           FavoritesView()
                .tabItem {
                    Label("Favoriler", systemImage: "star.fill")
                }
        }
    }
}

#Preview {
    MainTabView()
}

