import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/ads/admob_service.dart';
import '../../../core/constants/app_constants.dart';

/// What to show when the user completes the daily hydration goal.
enum GoalCelebrationKind {
  /// Nothing (already celebrated today or ads/promo disabled).
  none,

  /// Full-screen AdMob interstitial (marks day when dismissed).
  interstitial,

  /// In-app SnapBite promo dialog (day marked before dialog).
  snapbitePromo,
}

/// Alternates goal celebrations between AdMob interstitial and SnapBite promo.
class GoalCelebrationService {
  GoalCelebrationService({SharedPreferences? preferences})
    : _preferences = preferences;

  SharedPreferences? _preferences;

  Future<SharedPreferences> get _prefs async =>
      _preferences ??= await SharedPreferences.getInstance();

  Future<GoalCelebrationKind> onDailyGoalReached({
    required AdMobService admob,
    required String todayKey,
  }) async {
    final prefs = await _prefs;
    if (prefs.getString(AppConstants.prefGoalCelebrationDay) == todayKey) {
      return GoalCelebrationKind.none;
    }

    final preferInterstitial =
        prefs.getBool(AppConstants.prefGoalCelebrationPreferInterstitial) ??
        true;
    await prefs.setBool(
      AppConstants.prefGoalCelebrationPreferInterstitial,
      !preferInterstitial,
    );

    if (preferInterstitial && admob.adsEnabled) {
      await admob.onGoalReached(todayKey);
      return GoalCelebrationKind.interstitial;
    }

    await prefs.setString(AppConstants.prefGoalCelebrationDay, todayKey);
    return GoalCelebrationKind.snapbitePromo;
  }
}
