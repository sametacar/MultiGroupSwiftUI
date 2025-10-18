import Foundation

class WeatherService {

    private let apiKey = "9d801ba95051455018096afbcfb33ef7"
    private let baseURL = "https://api.openweathermap.org/data/2.5/weather"

    /// Get weather by city
    /// - Parameter city: City name. Format: "Istanbul" or "Istanbul,TR" (with country code)
    func fetchWeather(for city: String) async throws -> Weather {
        
        var components = URLComponents(string: baseURL)
        let cityQuery = city.contains(",") ? city : "\(city),TR"

        components?.queryItems = [
            URLQueryItem(name: "q", value: cityQuery),
            URLQueryItem(name: "appid", value: apiKey),
            URLQueryItem(name: "units", value: "metric"),
            URLQueryItem(name: "lang", value: "tr")
        ]

        guard let url = components?.url else {
            throw WeatherError.invalidURL
        }

        // Network request
        let (data, response) = try await URLSession.shared.data(from: url)

        // HTTP status check
        guard let httpResponse = response as? HTTPURLResponse else {
            throw WeatherError.invalidResponse
        }

        // Check for API error messages
        if !(200...299).contains(httpResponse.statusCode) {
            // Parse error message from API
            if let errorMessage = try? JSONDecoder().decode([String: String].self, from: data),
               let message = errorMessage["message"] {
            }
            throw WeatherError.apiError(statusCode: httpResponse.statusCode)
        }

        // JSON decode
        let apiResponse = try JSONDecoder().decode(WeatherAPIResponse.self, from: data)
        
        // Convert API response to WeatherData
        return convertToWeatherData(apiResponse)
    }

    /// Fetch weather by coordinates
    /// - Parameters:
    ///   - lat: Latitude
    ///   - lon: Longitude
    /// - Example: fetchWeather(lat: 41.0082, lon: 28.9784) // Istanbul
    func fetchWeather(lat: Double, lon: Double) async throws -> Weather {
        var components = URLComponents(string: baseURL)
        components?.queryItems = [
            URLQueryItem(name: "lat", value: "\(lat)"),
            URLQueryItem(name: "lon", value: "\(lon)"),
            URLQueryItem(name: "appid", value: apiKey),
            URLQueryItem(name: "units", value: "metric"),
            URLQueryItem(name: "lang", value: "tr")
        ]

        guard let url = components?.url else {
            throw WeatherError.invalidURL
        }

        /// Request
        let (data, response) = try await URLSession.shared.data(from: url)

        guard let httpResponse = response as? HTTPURLResponse,
              (200...299).contains(httpResponse.statusCode) else {
            throw WeatherError.invalidResponse
        }

        let apiResponse = try JSONDecoder().decode(WeatherAPIResponse.self, from: data)
        return convertToWeatherData(apiResponse)
    }

    // MARK: - Private Helpers

    private func convertToWeatherData(_ response: WeatherAPIResponse) -> Weather {
        // Convert Unix timestamp to Date
        let observationDate = Date(timeIntervalSince1970: response.dt)

        return Weather(
            temperature: Int(response.main.temp.rounded()),
            city: response.name,
            condition: response.weather.first?.description.capitalized ?? "Unknown",
            icon: mapWeatherIcon(response.weather.first?.id ?? 800),
            humidity: response.main.humidity,
            windSpeed: Int(response.wind.speed * 3.6), // m/s -> km/h
            observationTime: observationDate
        )
    }

    /// Map OpenWeatherMap weather ID to SF Symbol
    private func mapWeatherIcon(_ weatherId: Int) -> String {
        switch weatherId {
        case 200...232: // Thunderstorm
            return "cloud.bolt.rain.fill"
        case 300...321: // Drizzle
            return "cloud.drizzle.fill"
        case 500...531: // Rain
            return "cloud.rain.fill"
        case 600...622: // Snow
            return "snow"
        case 701...781: // Atmosphere (mist, fog, etc)
            return "cloud.fog.fill"
        case 800: // Clear
            return "sun.max.fill"
        case 801: // Few clouds
            return "cloud.sun.fill"
        case 802: // Scattered clouds
            return "cloud.fill"
        case 803...804: // Broken/overcast clouds
            return "smoke.fill"
        default:
            return "cloud.fill"
        }
    }
}

// MARK: - Weather Error

enum WeatherError: LocalizedError {
    case invalidURL
    case invalidResponse
    case apiError(statusCode: Int)
    case networkError
    case decodingError
    case invalidAPIKey

    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Geçersiz URL"
        case .invalidResponse:
            return "Sunucudan geçersiz yanıt"
        case .apiError(let statusCode):
            if statusCode == 401 {
                return "❌ API Key geçersiz! WeatherService.swift'te API key'i güncelleyin."
            }
            return "API Hatası (Kod: \(statusCode))"
        case .networkError:
            return "Ağ bağlantı hatası"
        case .decodingError:
            return "Veri işleme hatası"
        case .invalidAPIKey:
            return "API Key geçersiz"
        }
    }
}
