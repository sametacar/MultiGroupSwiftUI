import Foundation

class SharedWeatherManager {
    /// GroupID
    private static let appGroupID = "group.com.odevWidget.app"
    
    private enum StorageKey {
        static let lastWeatherData = "lastWeatherData"
        static let lastUpdateTime = "lastUpdateTime"
        static let selectedCity = "selectedCity"
    }

    // MARK: - Shared UserDefaults

    private static var sharedDefaults: UserDefaults? {
        UserDefaults(suiteName: appGroupID)
    }

    // MARK: - Save Weather Data

    static func saveWeatherData(_ data: Weather) {
        guard let defaults = sharedDefaults else {
            return
        }

        do {
            let encoder = JSONEncoder()
            let encoded = try encoder.encode(data)
            defaults.set(encoded, forKey: StorageKey.lastWeatherData)
            defaults.set(Date(), forKey: StorageKey.lastUpdateTime)
        } catch {}
    }

    // MARK: - Load Weather Data
    static func loadWeatherData() -> Weather? {
        guard let defaults = sharedDefaults else {
            return nil
        }

        guard let data = defaults.data(forKey: StorageKey.lastWeatherData) else {
            return nil
        }

        do {
            let decoder = JSONDecoder()
            let weatherData = try decoder.decode(Weather.self, from: data)
            
            return weatherData
        } catch {
            return nil
        }
    }

    // MARK: - Last Update Time
    static func getLastUpdateTime() -> Date? {
        sharedDefaults?.object(forKey: StorageKey.lastUpdateTime) as? Date
    }

    // MARK: - City Selection

    static func saveSelectedCity(_ city: String) {
        guard let defaults = sharedDefaults else { return }
        defaults.set(city, forKey: StorageKey.selectedCity)
    }

    static func loadSelectedCity() -> String? {
        sharedDefaults?.string(forKey: StorageKey.selectedCity)
    }
}
