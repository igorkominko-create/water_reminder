import Foundation

/// Keys must match `lib/data/widget/widget_data_keys.dart` (home_widget → UserDefaults).
enum HydrationWidgetData {
    static let appGroupId = "group.com.nexushealthlabs.waterreminder"

    static let keyGoalMl = "goal_ml"
    static let keyTodayMl = "today_ml"
    static let keyProgress = "progress"
    static let keyPercent = "percent"
    static let keyRemainingMl = "remaining_ml"
    static let keyGoalReached = "goal_reached"

    static func load() -> HydrationEntry {
        let prefs = UserDefaults(suiteName: appGroupId)
        let goal = prefs?.integer(forKey: keyGoalMl) ?? 2000
        let today = prefs?.integer(forKey: keyTodayMl) ?? 0
        let percentStored = prefs?.integer(forKey: keyPercent) ?? 0
        let progressStored = prefs?.double(forKey: keyProgress) ?? 0
        let remaining = prefs?.integer(forKey: keyRemainingMl) ?? max(0, goal - today)
        let reached = prefs?.bool(forKey: keyGoalReached) ?? (today >= goal && goal > 0)

        let progress: Double
        if progressStored > 0 {
            progress = min(1, max(0, progressStored))
        } else if goal > 0 {
            progress = min(1, max(0, Double(today) / Double(goal)))
        } else {
            progress = 0
        }

        let percent = percentStored > 0 ? percentStored : Int((progress * 100).rounded())

        return HydrationEntry(
            date: Date(),
            goalMl: goal,
            todayMl: today,
            percent: percent,
            progress: progress,
            remainingMl: remaining,
            goalReached: reached
        )
    }
}

struct HydrationEntry: TimelineEntry {
    let date: Date
    let goalMl: Int
    let todayMl: Int
    let percent: Int
    let progress: Double
    let remainingMl: Int
    let goalReached: Bool
}
