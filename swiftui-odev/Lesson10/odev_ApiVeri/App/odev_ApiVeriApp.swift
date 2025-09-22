//
//  odev_ApiVeriApp.swift
//  odev_ApiVeri
//
//  Created by vili on 21.09.2025.
//

import SwiftUI
import BuddiesNetwork

@main
struct odev_ApiVeriApp: App {
    init() {
        // Interceptor provider hazırla
       let urlSessionClient = URLSessionClient(sessionConfiguration: .default)
       let interceptorProvider = PokemonInterceptorProvider(client: urlSessionClient)
       
       // Transport hazırla
       let transport = DefaultRequestChainNetworkTransport(interceptorProvider: interceptorProvider)
       
       // API Client'i singleton olarak ata
       PokemonApiClient.shared = PokemonApiClient(networkTransporter: transport)
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: ContentViewModel(service: PokemonService()))
        }
    }
}
