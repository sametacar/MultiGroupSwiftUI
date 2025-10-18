import SwiftUI
import WidgetKit
import ActivityKit

struct WeatherDisplayView: View {
    @State private var weatherData: Weather?
    @State private var lastUpdateTime: Date?
    @State private var selectedCity: String = "Istanbul"
    @State private var isLoading: Bool = false
    @State private var currentActivity: Activity<WeatherActivityAttributes>?
    @State private var refreshCount: Int = 0
    
    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(
                    colors: [.orange.opacity(0.9), .orange.opacity(0.7)],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()

                if let weather = weatherData {
                    weatherContentView(for: weather)
                } else if isLoading {
                    loadingStateView
                } else {
                    emptyStateView
                }
            }
            .navigationTitle("İstanbul Hava Durumu")
            .font(.title2)
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(.ultraThinMaterial, for: .navigationBar)
        }
        .onAppear {
            loadSavedCity()
            loadWeatherData()
        }
    }
    
    private func loadSavedCity() {
        if let savedCity = SharedWeatherManager.loadSelectedCity() {
            selectedCity = savedCity
        }
    }
    
    private var emptyStateView: some View {
        VStack(spacing: 20) {
            Image(systemName: "exclamationmark.triangle.fill")
                .font(.system(size: 80))
                .foregroundStyle(.white.opacity(0.7))

            Text("Veri Bulunamadı")
                .font(.title.weight(.semibold))
                .foregroundStyle(.white)

            Text("Widget henüz yüklenmemiş.\nWidget'ı anasayfanıza ekleyin.")
                .font(.subheadline)
                .foregroundStyle(.white.opacity(0.8))
                .multilineTextAlignment(.center)

            Button {
                loadWeatherData()
            } label: {
                HStack {
                    Image(systemName: "arrow.clockwise")
                    Text("Tekrar Dene")
                    .font(.title3)
                }
                .foregroundStyle(.black)
                .padding(.horizontal, 22)
                .padding(.vertical, 10)
                .background(.white.opacity(0.85))
                .cornerRadius(12)
            }
            .padding(.top)
        }
    }
    
    private func weatherContentView(for weather: Weather) -> some View {
        VStack(spacing: 32) {
            VStack(spacing: 8) { // Header
                Text(weather.city)
                    .font(.system(size: 48, weight: .bold))
                    .foregroundStyle(.white)

                Text(weather.condition)
                    .font(.title2)
                    .foregroundStyle(.white.opacity(0.9))
            }

            HStack(spacing: 20) { // Temperature & Icon
                Image(systemName: weather.icon)
                    .font(.system(size: 120))
                    .foregroundStyle(.white)

                Text("\(weather.temperature)°")
                    .font(.system(size: 120, weight: .thin))
                    .foregroundStyle(.white)
            }

            HStack(spacing: 60) { // Details
                VStack(spacing: 12) {
                    Image(systemName: "humidity.fill")
                        .font(.title)
                    Text("Nem")
                        .font(.caption)
                    Text("\(weather.humidity)%")
                        .font(.title2.weight(.semibold))
                }
                .foregroundStyle(.white)

                VStack(spacing: 12) {
                    Image(systemName: "wind")
                        .font(.title)
                    Text("Rüzgar")
                        .font(.caption)
                    Text("\(weather.windSpeed) km/h")
                        .font(.title2.weight(.semibold))
                }
                .foregroundStyle(.white)
            }
            .padding(.top, 20)

            Spacer()

            VStack(spacing: 8) { // Footer
                if let updateTime = lastUpdateTime {
                    HStack(spacing: 8) {
                        Image(systemName: "clock.fill")
                            .font(.caption)
                        Text("Widget'tan son güncelleme: \(updateTime.formatted(date: .omitted, time: .standard))")
                            .font(.caption)
                    }
                    .foregroundStyle(.white.opacity(0.7))
                }

                Text("Bu veriler widget tarafından paylaşılıyor")
                    .font(.caption2)
                    .foregroundStyle(.white.opacity(0.5))
            }

            HStack(spacing: 16) { // Action Buttons
                Button { // Refresh Button
                    refreshWidget()
                } label: {
                    HStack {
                        Image(systemName: "arrow.clockwise")
                        Text("Widget'ı Yenile")
                    }
                    .font(.headline)
                    .foregroundStyle(.white)
                    .padding(.horizontal, 24)
                    .padding(.vertical, 12)
                    .background(.white.opacity(0.25))
                    .cornerRadius(12)
                }
                .disabled(isLoading)
                .opacity(isLoading ? 0.6 : 1.0)

                Button { // Live Activity Toggle
                    if currentActivity != nil {
                        stopLiveActivity()
                    } else {
                        startLiveActivity()
                    }
                } label: {
                    HStack {
                        Image(systemName: currentActivity != nil ? "stop.circle.fill" : "play.circle.fill")
                        Text(currentActivity != nil ? "Durdur" : "Live Activity")
                    }
                    .font(.headline)
                    .foregroundStyle(.white)
                    .padding(.horizontal, 24)
                    .padding(.vertical, 12)
                    .background(.white.opacity(0.25))
                    .cornerRadius(12)
                }
            }
        }
        .padding()
    }
    
    private var loadingStateView: some View {
        VStack(spacing: 20) {
            ProgressView()
                .scaleEffect(1.5)
                .tint(.white)

            Text("Yükleniyor...")
                .font(.title2.weight(.semibold))
                .foregroundStyle(.white)

            Text("Widget \(selectedCity) için güncelleniyor")
                .font(.subheadline)
                .foregroundStyle(.white.opacity(0.8))
        }
    }
    
    private func startLiveActivity() {
        
        guard ActivityAuthorizationInfo().areActivitiesEnabled else {
            return
        }

        // Önce widget'tan en güncel veriyi çek
        loadWeatherData()

        guard let updatedWeather = weatherData else { return }

        let attributes = WeatherActivityAttributes(cityName: selectedCity)
        let state = WeatherActivityAttributes.ContentState(
            temperature: updatedWeather.temperature,
            city: updatedWeather.city,
            condition: updatedWeather.condition,
            icon: updatedWeather.icon,
            lastUpdate: Date()
        )

        do {
            let activity = try Activity.request(
                attributes: attributes,
                content: .init(state: state, staleDate: nil),
                pushType: nil
            )
            currentActivity = activity
        } catch {}
    }

    private func stopLiveActivity() {
        guard let activity = currentActivity else { return }

        Task {
            await activity.end(nil, dismissalPolicy: .immediate)
            currentActivity = nil
        }
    }
    
    private func refreshWidget() {
        refreshCount += 1
       isLoading = true

        // Update widgets
        WidgetCenter.shared.reloadAllTimelines()

        // Widget update with delay
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            // Update
            loadWeatherData()
            isLoading = false
        }
    }

    private func loadWeatherData() {
        let oldTime = lastUpdateTime

        weatherData = SharedWeatherManager.loadWeatherData()
        lastUpdateTime = SharedWeatherManager.getLastUpdateTime()

        if weatherData != nil {
            updateLiveActivity()
        }
    }

    private func updateLiveActivity() {
        guard let activity = currentActivity,
              let weather = weatherData else { return }

        let updatedState = WeatherActivityAttributes.ContentState(
            temperature: weather.temperature,
            city: weather.city,
            condition: weather.condition,
            icon: weather.icon,
            lastUpdate: Date()
        )

        Task {
            await activity.update(.init(state: updatedState, staleDate: nil))
        }
    }
}

#Preview {
    WeatherDisplayView()
}
