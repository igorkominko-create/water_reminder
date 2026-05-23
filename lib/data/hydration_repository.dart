import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../core/constants/app_constants.dart';
import '../domain/hydration_state.dart';

class HydrationRepository {
  HydrationRepository(this._prefs);

  final SharedPreferences _prefs;

  static String _todayKey() => DateFormat('yyyy-MM-dd').format(DateTime.now());

  HydrationState load() {
    final todayKey = _todayKey();
    final storedDate = _prefs.getString(AppConstants.prefTodayDate);
    var todayMl = _prefs.getInt(AppConstants.prefTodayMl) ?? 0;
    if (storedDate != todayKey) {
      todayMl = 0;
    }
    final goalMl =
        _prefs.getInt(AppConstants.prefGoalMl) ?? AppConstants.defaultGoalMl;
    return HydrationState(
      goalMl: goalMl,
      todayMl: todayMl,
      todayKey: todayKey,
    );
  }

  Future<HydrationState> setGoal(int goalMl) async {
    await _prefs.setInt(AppConstants.prefGoalMl, goalMl);
    return load();
  }

  Future<HydrationState> addWater(int ml) async {
    final todayKey = _todayKey();
    final storedDate = _prefs.getString(AppConstants.prefTodayDate);
    var todayMl = _prefs.getInt(AppConstants.prefTodayMl) ?? 0;
    if (storedDate != todayKey) {
      todayMl = 0;
    }
    todayMl += ml;
    await _prefs.setString(AppConstants.prefTodayDate, todayKey);
    await _prefs.setInt(AppConstants.prefTodayMl, todayMl);
    return load();
  }

  Future<HydrationState> resetToday() async {
    final todayKey = _todayKey();
    await _prefs.setString(AppConstants.prefTodayDate, todayKey);
    await _prefs.setInt(AppConstants.prefTodayMl, 0);
    return load();
  }
}
