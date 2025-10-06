//
//  MainTabView.swift
//  odev_lokasyon
//
//  Created by vili on 6.10.2025.
//

import SwiftUI

struct MainTabView: View {
    @StateObject private var locationManager = LocationManager()
    
    var body: some View {
        TabView {
            MapView(locationManager: locationManager)
                .tabItem {
                    Label("Harita", systemImage: "map")
                }
                .onAppear {
                    locationManager.requestPermission()
                }
            
            FavoritesView()
                .tabItem {
                    Label("Noktalarım", systemImage: "mappin.and.ellipse")
                }
        }
    }
}

#Preview {
    MainTabView()
}
