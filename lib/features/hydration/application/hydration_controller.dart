import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../data/hydration_repository.dart';
import '../../../domain/hydration_state.dart';
import '../../widget/widget_bridge.dart';

final sharedPreferencesProvider = FutureProvider<SharedPreferences>((ref) async {
  return SharedPreferences.getInstance();
});

final hydrationRepositoryProvider = FutureProvider<HydrationRepository>((ref) async {
  final prefs = await ref.watch(sharedPreferencesProvider.future);
  return HydrationRepository(prefs);
});

final widgetBridgeProvider = Provider<WidgetBridge>((ref) => WidgetBridge());

final hydrationControllerProvider =
    AsyncNotifierProvider<HydrationController, HydrationState>(
  HydrationController.new,
);

class HydrationController extends AsyncNotifier<HydrationState> {
  @override
  Future<HydrationState> build() async {
    final repo = await ref.watch(hydrationRepositoryProvider.future);
    final bridge = ref.read(widgetBridgeProvider);
    await bridge.init();
    final state = repo.load();
    await bridge.sync(state);
    return state;
  }

  Future<void> addWater(int ml) async {
    final repo = await ref.read(hydrationRepositoryProvider.future);
    final bridge = ref.read(widgetBridgeProvider);
    final next = await repo.addWater(ml);
    state = AsyncData(next);
    await bridge.sync(next);
  }

  Future<void> setGoal(int goalMl) async {
    final repo = await ref.read(hydrationRepositoryProvider.future);
    final bridge = ref.read(widgetBridgeProvider);
    final next = await repo.setGoal(goalMl);
    state = AsyncData(next);
    await bridge.sync(next);
  }

  Future<void> resetToday() async {
    final repo = await ref.read(hydrationRepositoryProvider.future);
    final bridge = ref.read(widgetBridgeProvider);
    final next = await repo.resetToday();
    state = AsyncData(next);
    await bridge.sync(next);
  }
}
