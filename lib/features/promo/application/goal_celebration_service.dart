import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/constants/app_constants.dart';

/// What to show when the user completes the daily hydration goal.
enum GoalCelebrationKind {
  /// Already celebrated today.
  none,

  /// In-app SnapBite promo dialog.
  snapbitePromo,
}

/// Tracks daily goal celebrations (SnapBite cross-promo).
class GoalCelebrationService {
  GoalCelebrationService({SharedPreferences? preferences})
    : _preferences = preferences;

  SharedPreferences? _preferences;

  Future<SharedPreferences> get _prefs async =>
      _preferences ??= await SharedPreferences.getInstance();

  /// Marks today so [onDailyGoalReached] will not run again until the next day.
  Future<void> markCelebratedToday(String todayKey) async {
    final prefs = await _prefs;
    await prefs.setString(AppConstants.prefGoalCelebrationDay, todayKey);
  }

  Future<GoalCelebrationKind> onDailyGoalReached({
    required String todayKey,
  }) async {
    final prefs = await _prefs;
    if (prefs.getString(AppConstants.prefGoalCelebrationDay) == todayKey) {
      return GoalCelebrationKind.none;
    }

    await prefs.setString(AppConstants.prefGoalCelebrationDay, todayKey);
    return GoalCelebrationKind.snapbitePromo;
  }
}
