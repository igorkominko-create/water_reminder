import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/constants/app_constants.dart';

/// Low-level persistence for hydration counters (app + widget backup).
class HydrationPrefsStore {
  HydrationPrefsStore(this._prefs);

  final SharedPreferences _prefs;

  static String todayKey() => DateFormat('yyyy-MM-dd').format(DateTime.now());

  int readGoalMl() =>
      _prefs.getInt(AppConstants.prefGoalMl) ?? AppConstants.defaultGoalMl;

  int readTodayMl(String todayKey) {
    final storedDate = _prefs.getString(AppConstants.prefTodayDate);
    if (storedDate != todayKey) return 0;
    return _prefs.getInt(AppConstants.prefTodayMl) ?? 0;
  }

  Future<void> writeGoalMl(int goalMl) =>
      _prefs.setInt(AppConstants.prefGoalMl, goalMl);

  Future<void> writeToday(String todayKey, int todayMl) async {
    await _prefs.setString(AppConstants.prefTodayDate, todayKey);
    await _prefs.setInt(AppConstants.prefTodayMl, todayMl);
  }
}
