import ActivityKit
import Foundation

struct WeatherActivityAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        var temperature: Int
        var city: String
        var condition: String
        var icon: String
        var lastUpdate: Date
    }

    var cityName: String
}
