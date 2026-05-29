import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:water_reminder/core/constants/app_constants.dart';
import 'package:water_reminder/features/promo/application/goal_celebration_service.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  test('marks day and returns SnapBite promo', () async {
    final prefs = await SharedPreferences.getInstance();
    final service = GoalCelebrationService(preferences: prefs);

    const day = '2026-05-22';

    final kind = await service.onDailyGoalReached(todayKey: day);
    expect(kind, GoalCelebrationKind.snapbitePromo);
    expect(prefs.getString(AppConstants.prefGoalCelebrationDay), day);
  });

  test('markCelebratedToday prevents duplicate celebrations', () async {
    final prefs = await SharedPreferences.getInstance();
    final service = GoalCelebrationService(preferences: prefs);

    const day = '2026-05-29';
    await service.markCelebratedToday(day);

    final kind = await service.onDailyGoalReached(todayKey: day);
    expect(kind, GoalCelebrationKind.none);
  });

  test('returns none when celebration already shown today', () async {
    final prefs = await SharedPreferences.getInstance()
      ..setString(AppConstants.prefGoalCelebrationDay, '2026-05-22');
    final service = GoalCelebrationService(preferences: prefs);

    final kind = await service.onDailyGoalReached(todayKey: '2026-05-22');
    expect(kind, GoalCelebrationKind.none);
  });
}
