import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:water_reminder/data/local/hydration_prefs_store.dart';
import 'package:water_reminder/data/repositories/hydration_repository_impl.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  test('addWater accumulates intake for today', () async {
    final prefs = await SharedPreferences.getInstance();
    final repo = HydrationRepositoryImpl(HydrationPrefsStore(prefs));

    await repo.addWater(250);
    final after = await repo.addWater(150);

    expect(after.todayMl, 400);
  });

  test('setGoal updates goal', () async {
    final prefs = await SharedPreferences.getInstance();
    final repo = HydrationRepositoryImpl(HydrationPrefsStore(prefs));

    final state = await repo.setGoal(2500);
    expect(state.goalMl, 2500);
  });
}
