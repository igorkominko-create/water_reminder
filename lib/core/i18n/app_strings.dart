/// English UI copy (app is English-only for v1).
abstract final class AppStrings {
  static const String appName = 'Water Reminder';

  static const String homeTitle = 'Water Reminder';
  static const String settings = 'Settings';
  static const String settingsTooltip = 'Settings';

  static String mlToGo(int ml) => '$ml ml to go';
  static const String goalReachedHeadline = 'You\'re fully hydrated';

  static const String addWater = 'Add water';
  static const String customAmountHint = 'Custom amount (ml)';
  static const String addCustom = 'Add';
  static String invalidAmountMessage(int min, int max) =>
      'Enter an amount between $min and $max ml';
  static String mlAmount(int ml) => '$ml';
  static String mlWithUnit(int ml) => '$ml ml';
  static const String mlLabel = 'ml';
  static String ofDailyGoal(int goalMl) => 'of $goalMl ml';

  static const String widgetHint =
      'Add a widget on your Home or Lock Screen — it updates when you log water here.';

  static const String dailyGoalTitle = 'Daily goal (ml)';
  static const String dailyGoalHint = '2000';
  static const String saveGoal = 'Save goal';
  static const String invalidGoalMessage =
      'Enter a goal between 250 and 10000 ml';

  static const String resetTodayTitle = 'Reset today?';
  static const String resetTodayMessage =
      'Clears today\'s intake. Widgets will update too.';
  static const String cancel = 'Cancel';
  static const String reset = 'Reset';
  static const String resetToday = 'Reset today';

  static String errorMessage(Object error) => 'Error: $error';
}
