import WidgetKit
import SwiftUI

struct NetworkProvider: TimelineProvider {
    typealias Entry = WeatherEntry
    
    private let weatherService = WeatherService()
    
    private var selectedCity: String {
        SharedWeatherManager.loadSelectedCity() ?? "Istanbul"
    }
    
    func placeholder(in context: Context) -> WeatherEntry {
        WeatherEntry(date: Date(), weather: .mock)
    }
    
    func getSnapshot(in context: Context, completion: @escaping @Sendable (WeatherEntry) -> Void) {
        // Use mock data in preview mode
        if context.isPreview {
            completion(WeatherEntry(date: Date(), weather: .mock))
            return
        }

        // Fetch real data in normal mode
        Task {
            do {
                let weather = try await weatherService.fetchWeather(for: selectedCity)
                let entry = WeatherEntry(date: Date(), weather: weather)
                completion(entry)
            } catch {
                completion(WeatherEntry(date: Date(), weather: .mock))
            }
        }
    }
    
    func getTimeline(in context: Context, completion: @escaping @Sendable (Timeline<WeatherEntry>) -> Void) {
        Task {
            do {
                let weather = try await weatherService.fetchWeather(for: selectedCity)
                
                // Save to App Group shared storage
                SharedWeatherManager.saveWeatherData(weather)

                let currentDate = Date()

                // Updated Entry
                let entry = WeatherEntry(date: currentDate, weather: weather)

                // Api call for per 5 min.
                let nextUpdate = Calendar.current.date(byAdding: .minute, value: 5, to: currentDate)!
                let timeline = Timeline(entries: [entry], policy: .after(nextUpdate))
                completion(timeline)

            } catch {
                handleError(error, completion: completion)
            }
        }
    }
    
    // MARK: - Error Handling
    private func handleError(_ error: Error, completion: @escaping (Timeline<WeatherEntry>) -> Void) {
        let currentDate = Date()

        // Custom WeatherData for error state
        let errorWeather = Weather(
            temperature: 0,
            city: "-",
            condition: error.localizedDescription,
            icon: "exclamationmark.triangle.fill",
            humidity: 0,
            windSpeed: 0,
            observationTime: nil
        )

        let entry = WeatherEntry(date: currentDate, weather: errorWeather)

        // Retry after 10 minutes
        let nextUpdate = Calendar.current.date(byAdding: .minute, value: 10, to: currentDate)!
        let timeline = Timeline(entries: [entry], policy: .after(nextUpdate))

        completion(timeline)
    }
}
