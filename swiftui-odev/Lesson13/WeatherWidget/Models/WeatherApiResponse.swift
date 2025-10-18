import Foundation

/// Weather Api Response Model
struct WeatherAPIResponse: Codable {
    let main: Main
    let weather: [Weather]
    let wind: Wind
    let name: String
    let dt: TimeInterval

    struct Main: Codable {
        let temp: Double
        let humidity: Int
    }

    struct Weather: Codable {
        let id: Int
        let main: String
        let description: String
        let icon: String
    }

    struct Wind: Codable {
        let speed: Double
    }
}
