import WidgetKit

/// Main View Model l
struct WeatherEntry: TimelineEntry {
    let date: Date
    let weather: Weather
}

/// Weather View Model
struct Weather: Codable {
    let temperature: Int
    let city: String
    let condition: String
    let icon: String
    let humidity: Int
    let windSpeed: Int
    let observationTime: Date?
}

/// MARK - Mock Model
extension Weather {
    static let mock = Weather(
        temperature: 34,
        city: "İstanbul",
        condition: "Güneşli",
        icon: "sun.max.fill",
        humidity: 65,
        windSpeed: 12,
        observationTime: nil
    )
}
