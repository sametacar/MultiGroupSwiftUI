import ActivityKit
import WidgetKit
import SwiftUI

struct WeatherLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: WeatherActivityAttributes.self) { context in
            lockScreenView(context: context)
        } dynamicIsland: { context in
            DynamicIsland {
                DynamicIslandExpandedRegion(.leading) {
                    expandedLeading(context: context)
                }
                DynamicIslandExpandedRegion(.trailing) {
                    expandedTrailing(context: context)
                }
                DynamicIslandExpandedRegion(.bottom) {
                    expandedBottom(context: context)
                }
            } compactLeading: {
                Image(systemName: context.state.icon)
                    .font(.caption2)
            } compactTrailing: {
                Text("\(context.state.temperature)°")
                    .font(.caption.weight(.semibold))
            } minimal: {
                Image(systemName: context.state.icon)
            }
        }
    }

    // MARK: - Lock Screen View

    @ViewBuilder
    private func lockScreenView(context: ActivityViewContext<WeatherActivityAttributes>) -> some View {
        HStack(spacing: 12) {
            Image(systemName: context.state.icon)
                .font(.title2)
                .foregroundStyle(.white)

            VStack(alignment: .leading, spacing: 2) {
                Text(context.attributes.cityName)
                    .font(.headline)
                    .foregroundStyle(.white)

                Text(context.state.condition)
                    .font(.caption)
                    .foregroundStyle(.white.opacity(0.8))
            }

            Spacer()

            Text("\(context.state.temperature)°")
                .font(.system(size: 36, weight: .bold))
                .foregroundStyle(.white)
        }
        .padding()
        .background(
            LinearGradient(
                colors: [.blue.opacity(0.6), .cyan.opacity(0.4)],
                startPoint: .leading,
                endPoint: .trailing
            )
        )
    }

    // MARK: - Dynamic Island Expanded Views

    @ViewBuilder
    private func expandedLeading(context: ActivityViewContext<WeatherActivityAttributes>) -> some View {
        VStack(alignment: .leading, spacing: 4) {
            Image(systemName: context.state.icon)
                .font(.title)
                .foregroundStyle(.blue)

            Text(context.attributes.cityName)
                .font(.caption.weight(.semibold))
        }
    }

    @ViewBuilder
    private func expandedTrailing(context: ActivityViewContext<WeatherActivityAttributes>) -> some View {
        VStack(alignment: .trailing, spacing: 4) {
            Text("\(context.state.temperature)°")
                .font(.system(size: 32, weight: .bold))

            Text(context.state.lastUpdate, style: .time)
                .font(.caption2)
                .foregroundStyle(.secondary)
        }
    }

    @ViewBuilder
    private func expandedBottom(context: ActivityViewContext<WeatherActivityAttributes>) -> some View {
        HStack {
            Text(context.state.condition)
                .font(.subheadline)
                .foregroundStyle(.secondary)

            Spacer()

            Link(destination: URL(string: "weatherwidget://")!) {
                Text("Open App")
                    .font(.caption.weight(.semibold))
                    .padding(.horizontal, 12)
                    .padding(.vertical, 6)
                    .background(.blue)
                    .foregroundStyle(.white)
                    .cornerRadius(8)
            }
        }
    }
}
