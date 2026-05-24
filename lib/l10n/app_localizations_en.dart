// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'Water Reminder';

  @override
  String get homeTitle => 'Water Reminder';

  @override
  String get settings => 'Settings';

  @override
  String get settingsTooltip => 'Settings';

  @override
  String mlToGo(int ml) {
    return '$ml ml to go';
  }

  @override
  String get goalReachedHeadline => 'Daily goal complete';

  @override
  String get addWater => 'Add water';

  @override
  String get customAmountHint => 'Custom amount (ml)';

  @override
  String get addCustom => 'Add';

  @override
  String invalidAmountMessage(int min, int max) {
    return 'Enter an amount between $min and $max ml';
  }

  @override
  String mlWithUnit(int ml) {
    return '$ml ml';
  }

  @override
  String get mlLabel => 'ml';

  @override
  String ofDailyGoal(int goalMl) {
    return 'of $goalMl ml';
  }

  @override
  String get widgetHint =>
      'Add a widget on your Home or Lock Screen — it updates when you log water here.';

  @override
  String get dailyGoalTitle => 'Daily goal (ml)';

  @override
  String get dailyGoalHint => '2000';

  @override
  String get saveGoal => 'Save goal';

  @override
  String get invalidGoalMessage => 'Enter a goal between 250 and 10000 ml';

  @override
  String get resetTodayTitle => 'Reset today?';

  @override
  String get resetTodayMessage =>
      'Clears today\'s intake. Widgets will update too.';

  @override
  String get cancel => 'Cancel';

  @override
  String get reset => 'Reset';

  @override
  String get resetToday => 'Reset today';

  @override
  String errorMessage(String error) {
    return 'Error: $error';
  }

  @override
  String get trackingUsageDescription =>
      'This allows us to show ads that are more relevant to you and support the free app.';

  @override
  String get snapbitePromoTitle => 'Try SnapBite';

  @override
  String get snapbitePromoSubtitle =>
      'Your AI-powered food tracking companion. Scan meals in seconds!';

  @override
  String get goalSuccessPromoTitle => 'Great job!';

  @override
  String get goalSuccessPromoMessage =>
      'Daily goal achieved! 💧 Want to boost your fitness results? Try our AI Food Scanner – SnapBite!';

  @override
  String get goalSuccessPromoDownload => 'Download Free';

  @override
  String get goalSuccessPromoLater => 'Maybe later';
}
