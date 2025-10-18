import SwiftUI
import WidgetKit

struct MediumWidgetView: View {
    let weather: Weather
    let lastUpdate: Date

    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 20) {
                VStack(alignment: .leading, spacing: 4) {
                    Image(systemName: weather.icon)
                        .font(.system(size: 44))
                        .foregroundStyle(.white)

                    Text("\(weather.temperature)°")
                        .font(.system(size: 38, weight: .bold))
                        .foregroundStyle(.white)

                    Text(weather.city)
                        .font(.title3.weight(.semibold))
                        .foregroundStyle(.white.opacity(0.9))
                } //: HStack

                Spacer()

                VStack(alignment: .trailing, spacing: 12) {
                    Button(intent: RefreshWeatherIntent()) {
                        HStack(spacing: 4) {
                            Image(systemName: "arrow.clockwise")
                            Text("Yenile")
                        }
                        .font(.subheadline)
                        .foregroundStyle(.white.opacity(0.8))
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(.white.opacity(0.15))
                        .cornerRadius(8)
                    }
                    .buttonStyle(.plain)

                    Text(weather.condition)
                        .font(.subheadline)
                        .foregroundStyle(.black.opacity(0.6))

                   

                    HStack {
                        Image(systemName: "humidity.fill")
                        Text("\(weather.humidity)%")
                    }
                    .font(.caption)
                    .foregroundStyle(.black.opacity(0.6))

                    HStack {
                        Image(systemName: "wind")
                        Text("\(weather.windSpeed) km/h")
                    }
                    .font(.caption)
                    .foregroundStyle(.black.opacity(0.6))
                } //: VStack
            }

            Spacer()

            HStack {
                Text("Son güncelleme: \(lastUpdate, style: .time)")
                    .font(.caption2)
            }
            .foregroundStyle(.black.opacity(0.4))
        } //: VStack
        .padding()
    } //: body
}

#Preview("Medium Widget", as: .systemMedium) {
    WeatherWidget()
} timeline: {
    WeatherEntry(date: .now, weather: .mock)
}
