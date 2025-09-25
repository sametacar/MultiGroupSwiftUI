//
//  odev_ApiVeriListApp.swift
//  odev_ApiVeriList
//
//  Created by vili on 24.09.2025.
//

import SwiftUI
import BuddiesNetwork

@main
struct odev_ApiVeriListApp: App {
    init() {
        let urlSessionClient = URLSessionClient(sessionConfiguration: .default)
        let interceptorProvider = RickInterceptorProvider(client: urlSessionClient)
        let transport = DefaultRequestChainNetworkTransport(interceptorProvider: interceptorProvider)
       
        RickApiClient.shared = RickApiClient(networkTransporter: transport)
    }
    
    var body: some Scene {
        WindowGroup {
            //ContentView(viewModel: ContentViewModel(service: RickService()))
            MainTabView()
        }
    }
}
