import AppIntents
import WidgetKit

struct RefreshWeatherIntent: AppIntent {
    static var title: LocalizedStringResource = "Hava Durumunu Yenile"
    static var description = IntentDescription("Hava durumunu güncelle")

    func perform() async throws -> some IntentResult {
        WidgetCenter.shared.reloadAllTimelines()
        return .result()
    }
}
