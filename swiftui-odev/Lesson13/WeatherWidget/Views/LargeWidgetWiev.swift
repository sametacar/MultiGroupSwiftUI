import SwiftUI
import WidgetKit

struct LargeWidgetView: View {
    let weather: Weather
    let lastUpdate: Date

    var body: some View {
        VStack(spacing: 24) {
            HStack {
                VStack(alignment: .leading) {
                    Text(weather.city)
                        .font(.title.weight(.semibold))
                        .foregroundStyle(.black.opacity(0.6))

                    Text(weather.condition)
                        .font(.title3)
                        .foregroundStyle(.black.opacity(0.6))
                } //: VStack

                Spacer()

                VStack(alignment: .trailing, spacing: 8) {
                    Button(intent: RefreshWeatherIntent()) {
                        HStack(spacing: 6) {
                            Image(systemName: "arrow.clockwise")
                            Text("Yenile")
                        }
                        .font(.title3)
                        .foregroundStyle(.white)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 6)
                        .background(.white.opacity(0.15))
                        .cornerRadius(10)
                    }
                    .buttonStyle(.plain)

                    HStack(spacing: 4) {
                        Image(systemName: "clock.fill")
                            .font(.caption)
                        Text(lastUpdate, style: .time)
                            .font(.caption2)
                    } //: HStack
                    .foregroundStyle(.white.opacity(0.5))
                } //: VStack
            } //: HStack

            HStack {
                Image(systemName: weather.icon)
                    .font(.system(size: 80))
                    .foregroundStyle(.white)

                Text("\(weather.temperature)°")
                    .font(.system(size: 80, weight: .bold))
                    .foregroundStyle(.white)
            }

            HStack(spacing: 80) {
                VStack(spacing: 4) {
                    Image(systemName: "humidity.fill")
                        .font(.title)
                    Text("Nem")
                        .font(.caption)
                    Text("\(weather.humidity)%")
                        .font(.title3.weight(.semibold))
                      
                } //: VStack
                .foregroundStyle(.black.opacity(0.4))

                VStack(spacing: 4) {
                    Image(systemName: "wind")
                        .font(.title)
                    Text("Rüzgar")
                        .font(.caption)
                    Text("\(weather.windSpeed) km/h")
                        .font(.title3.weight(.semibold))
                }
                .foregroundStyle(.black.opacity(0.4))
            } //: HStack
            .padding(.top, 2)
        } //: VStack
        .padding()
    }
}

#Preview("Large Widget", as: .systemLarge) {
    WeatherWidget()
} timeline: {
    WeatherEntry(date: .now, weather: .mock)
}
