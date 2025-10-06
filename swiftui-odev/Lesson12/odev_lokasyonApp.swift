import SwiftUI
import SwiftData

@main
struct odev_lokasyonApp: App {
    var body: some Scene {
        WindowGroup {
           MainTabView()
                .modelContainer(for: Point.self)
        }
    }
}
