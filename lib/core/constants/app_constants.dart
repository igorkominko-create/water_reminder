/// Shared keys and defaults for hydration tracking and widgets.
abstract final class AppConstants {
  static const String appName = 'Water Reminder';

  /// Default daily goal (milliliters).
  static const int defaultGoalMl = 2000;

  static const List<int> quickAddMl = [150, 250, 350, 500];

  static const int minAddMl = 1;
  static const int maxAddMl = 10000;

  static const String prefGoalMl = 'goal_ml';
  static const String prefTodayDate = 'today_date';
  static const String prefTodayMl = 'today_ml';

  /// Last calendar day a goal celebration (ad or SnapBite promo) was shown.
  static const String prefGoalCelebrationDay = 'goal_celebration_day';

  /// When true, the next goal celebration prefers AdMob interstitial; toggles each time.
  static const String prefGoalCelebrationPreferInterstitial =
      'goal_celebration_prefer_interstitial';

  static const String widgetGroupId = 'group.com.nexushealthlabs.waterreminder';
  static const String widgetDeepLinkScheme = 'waterreminder';
  static const String androidWidgetName = 'WaterWidgetProvider';
  static const String iosWidgetName = 'WaterWidget';
}
