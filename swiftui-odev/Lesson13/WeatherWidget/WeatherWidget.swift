//
//  WeatherWidget.swift
//  WeatherWidget
//
//  Created by vili on 15.10.2025.
//

import WidgetKit
import SwiftUI

struct WeatherWidgetEntryView : View {
    var entry: NetworkProvider.Entry
    @Environment(\.widgetFamily) var family

    var body: some View {
        switch family {
            case .systemSmall:
                SmallWidgetView(weather: entry.weather, lastUpdate: entry.date)
            case .systemMedium:
                MediumWidgetView(weather: entry.weather, lastUpdate: entry.date)
            case .systemLarge:
                LargeWidgetView(weather: entry.weather, lastUpdate: entry.date)
           default:
                SmallWidgetView(weather: entry.weather, lastUpdate: entry.date)
           }
    } //: body
}

struct WeatherWidget: Widget {
    let kind: String = "WeatherWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: NetworkProvider()) { entry in
            WeatherWidgetEntryView(entry: entry)
                .containerBackground(for: .widget) {
                    LinearGradient(
                        colors: [.orange.opacity(0.7), .orange.opacity(1)],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                }
        } //: StaticConfiguration
        .configurationDisplayName("Hava Durumu")
        .description("Hava durumu bilgisi")
        .supportedFamilies([.systemSmall, .systemMedium, .systemLarge])
    } //: body
}

#Preview("Small", as: .systemSmall) {
    WeatherWidget()
} timeline: {
    WeatherEntry(date: .now, weather: .mock)
}

#Preview("Medium", as: .systemMedium) {
    WeatherWidget()
} timeline: {
    WeatherEntry(date: .now, weather: .mock)
}

#Preview("Large", as: .systemLarge) {
    WeatherWidget()
} timeline: {
    WeatherEntry(date: .now, weather: .mock)
}
