import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:water_reminder/core/ads/admob_service.dart';
import 'package:water_reminder/core/constants/app_constants.dart';
import 'package:water_reminder/features/promo/application/goal_celebration_service.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  test('marks day and shows SnapBite when ads are disabled', () async {
    final prefs = await SharedPreferences.getInstance();
    final service = GoalCelebrationService(preferences: prefs);
    final admob = AdMobService(adsEnabled: false, preferences: prefs);

    const day = '2026-05-22';

    final kind = await service.onDailyGoalReached(admob: admob, todayKey: day);
    expect(kind, GoalCelebrationKind.snapbitePromo);
    expect(prefs.getString(AppConstants.prefGoalCelebrationDay), day);
  });

  test('toggles interstitial preference on each celebration', () async {
    final prefs = await SharedPreferences.getInstance();
    final service = GoalCelebrationService(preferences: prefs);
    final admob = AdMobService(adsEnabled: false, preferences: prefs);

    await service.onDailyGoalReached(admob: admob, todayKey: 'd1');
    expect(
      prefs.getBool(AppConstants.prefGoalCelebrationPreferInterstitial),
      false,
    );

    await prefs.remove(AppConstants.prefGoalCelebrationDay);
    await service.onDailyGoalReached(admob: admob, todayKey: 'd2');
    expect(
      prefs.getBool(AppConstants.prefGoalCelebrationPreferInterstitial),
      true,
    );
  });

  test('returns none when celebration already shown today', () async {
    final prefs = await SharedPreferences.getInstance()
      ..setString(AppConstants.prefGoalCelebrationDay, '2026-05-22');
    final service = GoalCelebrationService(preferences: prefs);
    final admob = AdMobService(adsEnabled: false, preferences: prefs);

    final kind = await service.onDailyGoalReached(
      admob: admob,
      todayKey: '2026-05-22',
    );
    expect(kind, GoalCelebrationKind.none);
  });
}
