/// Keys written by Flutter and read by iOS WidgetKit / Android AppWidget.
///
/// iOS: `UserDefaults(suiteName: AppConstants.widgetGroupId)`
/// Android: `HomeWidgetPlugin` shared preferences in [WaterWidgetProvider].
abstract final class WidgetDataKeys {
  static const String goalMl = 'goal_ml';
  static const String todayMl = 'today_ml';
  static const String progress = 'progress';
  static const String percent = 'percent';
  static const String remainingMl = 'remaining_ml';
  static const String goalReached = 'goal_reached';
  static const String updatedAt = 'updated_at';
}
