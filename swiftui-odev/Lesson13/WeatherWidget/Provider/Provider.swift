import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    typealias Entry = WeatherEntry

    func placeholder(in context: Context) -> WeatherEntry {
        WeatherEntry(date: Date(), weather: .mock)
    }

    func getSnapshot(in context: Context, completion: @escaping @Sendable (WeatherEntry) -> Void) {
        let entry = WeatherEntry(date: Date(), weather: .mock)
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping @Sendable (Timeline<WeatherEntry>) -> Void) {
        let currentDate = Date()
        var entries: [WeatherEntry] = []

        for hourOffset in 0..<5 {
            let entryDate = Calendar.current.date(byAdding: .minute, value: hourOffset * 15, to: currentDate)!
            let entry = WeatherEntry(date: entryDate, weather: .mock)
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}
