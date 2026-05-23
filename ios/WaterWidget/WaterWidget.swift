import SwiftUI
import WidgetKit

/// Timeline provider — reads App Group UserDefaults written by Flutter `home_widget`.
struct WaterWidgetProvider: TimelineProvider {
    func placeholder(in context: Context) -> HydrationEntry {
        HydrationEntry(
            date: Date(),
            goalMl: 2000,
            todayMl: 0,
            percent: 0,
            progress: 0,
            remainingMl: 2000,
            goalReached: false
        )
    }

    func getSnapshot(in context: Context, completion: @escaping (HydrationEntry) -> Void) {
        completion(HydrationWidgetData.load())
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<HydrationEntry>) -> Void) {
        let entry = HydrationWidgetData.load()
        // Flutter calls WidgetCenter.reloadTimelines after each log; policy .never is fine.
        let timeline = Timeline(entries: [entry], policy: .never)
        completion(timeline)
    }
}

/// `kind` must equal `AppConstants.iosWidgetName` / `HomeWidget.updateWidget(iOSName:)` in Dart.
@main
struct WaterWidget: Widget {
    let kind: String = "WaterWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: WaterWidgetProvider()) { entry in
            if #available(iOSApplicationExtension 17.0, *) {
                WaterWidgetEntryView(entry: entry)
                    .containerBackground(for: .widget) {
                        Color.clear
                    }
            } else {
                WaterWidgetEntryView(entry: entry)
            }
        }
        .configurationDisplayName("Water")
        .description("Track today's hydration on Home and Lock Screen.")
        .supportedFamilies([
            .systemSmall,
            .accessoryCircular,
            .accessoryRectangular,
        ])
    }
}

#if DEBUG
struct WaterWidget_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            WaterWidgetEntryView(
                entry: HydrationEntry(
                    date: Date(),
                    goalMl: 2000,
                    todayMl: 750,
                    percent: 38,
                    progress: 0.375,
                    remainingMl: 1250,
                    goalReached: false
                )
            )
            .previewContext(WidgetPreviewContext(family: .systemSmall))

            WaterWidgetEntryView(
                entry: HydrationEntry(
                    date: Date(),
                    goalMl: 2000,
                    todayMl: 2000,
                    percent: 100,
                    progress: 1,
                    remainingMl: 0,
                    goalReached: true
                )
            )
            .previewContext(WidgetPreviewContext(family: .accessoryCircular))

            WaterWidgetEntryView(
                entry: HydrationEntry(
                    date: Date(),
                    goalMl: 2000,
                    todayMl: 500,
                    percent: 25,
                    progress: 0.25,
                    remainingMl: 1500,
                    goalReached: false
                )
            )
            .previewContext(WidgetPreviewContext(family: .accessoryRectangular))
        }
    }
}
#endif
