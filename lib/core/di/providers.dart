import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/local/hydration_prefs_store.dart';
import '../../data/repositories/hydration_repository_impl.dart';
import '../../data/widget/home_widget_sync_repository.dart';
import '../../domain/entities/hydration_snapshot.dart';
import '../../domain/repositories/hydration_repository.dart';
import '../../domain/repositories/widget_sync_repository.dart';
import '../../features/hydration/application/hydration_notifier.dart';
import '../../features/promo/application/goal_celebration_service.dart';

// ——— Infrastructure ———

final sharedPreferencesProvider = FutureProvider<SharedPreferences>((ref) async {
  return SharedPreferences.getInstance();
});

final hydrationPrefsStoreProvider = FutureProvider<HydrationPrefsStore>((ref) async {
  final prefs = await ref.watch(sharedPreferencesProvider.future);
  return HydrationPrefsStore(prefs);
});

// ——— Domain contracts (injectable for tests) ———

final hydrationRepositoryProvider = FutureProvider<HydrationRepository>((ref) async {
  final store = await ref.watch(hydrationPrefsStoreProvider.future);
  return HydrationRepositoryImpl(store);
});

final widgetSyncRepositoryProvider = Provider<WidgetSyncRepository>((ref) {
  return HomeWidgetSyncRepository();
});

final goalCelebrationServiceProvider = Provider<GoalCelebrationService>((ref) {
  return GoalCelebrationService();
});

/// Set to true after goal completion when the SnapBite promo dialog should show.
final pendingSnapbiteGoalPromoProvider = StateProvider<bool>((ref) => false);

/// SnapBite goal dialog is shown at most once per app session.
final snapbiteGoalPromoShownThisSessionProvider =
    StateProvider<bool>((ref) => false);

// ——— Application state ———

final hydrationNotifierProvider =
    AsyncNotifierProvider<HydrationNotifier, HydrationSnapshot>(
  HydrationNotifier.new,
);
