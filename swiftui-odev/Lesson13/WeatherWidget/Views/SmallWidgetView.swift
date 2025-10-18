import WidgetKit
import SwiftUI

struct SmallWidgetView: View {
    let weather: Weather
    let lastUpdate: Date

    var body: some View {
        VStack(spacing: 6) {
           HStack(spacing: 2) {
                Image(systemName: weather.icon)
                    .font(.system(size: 36))
                    .foregroundStyle(.white)
                
                Text("\(weather.temperature)°")
                    .font(.system(size: 36, weight: .bold))
                    .foregroundStyle(.white)
           } //: Hstack
            
            Text(weather.condition)
                .font(.title2)
                .foregroundStyle(.white)

            Text(weather.city)
                .font(.subheadline)
                .foregroundStyle(.white.opacity(0.8))
            
            HStack() {
                Text(lastUpdate, style: .time)
                    .font(.caption2)
                    .foregroundStyle(.white.opacity(0.6))
                Spacer()
                Button(intent: RefreshWeatherIntent()) {
                    Image(systemName: "arrow.clockwise")
                        .font(.caption)
                        .foregroundStyle(.white.opacity(0.9))
                }
                .buttonStyle(.plain)
            } //: Hstack
        } //: VStack
        .padding(6)
    } //: body
}

#Preview("Small Widget", as: .systemSmall) {
    WeatherWidget()
} timeline: {
    WeatherEntry(date: .now, weather: .mock)
}
