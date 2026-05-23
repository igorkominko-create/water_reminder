/// Shared keys and defaults for hydration tracking and widgets.
abstract final class AppConstants {
  static const String appName = 'Water Reminder';

  /// Default daily goal (milliliters).
  static const int defaultGoalMl = 2000;

  static const List<int> quickAddMl = [150, 250, 350, 500];

  static const String prefGoalMl = 'goal_ml';
  static const String prefTodayDate = 'today_date';
  static const String prefTodayMl = 'today_ml';

  static const String widgetGroupId = 'group.com.nexushealthlabs.waterreminder';
  static const String widgetDeepLinkScheme = 'waterreminder';
  static const String androidWidgetName = 'WaterWidgetProvider';
  static const String iosWidgetName = 'WaterWidget';
}
