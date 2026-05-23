import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../ads/admob_service.dart';
import '../../data/local/hydration_prefs_store.dart';
import '../../data/repositories/hydration_repository_impl.dart';
import '../../data/widget/home_widget_sync_repository.dart';
import '../../domain/entities/hydration_snapshot.dart';
import '../../domain/repositories/hydration_repository.dart';
import '../../domain/repositories/widget_sync_repository.dart';
import '../../features/hydration/application/hydration_notifier.dart';

// ——— Infrastructure ———

final sharedPreferencesProvider = FutureProvider<SharedPreferences>((
  ref,
) async {
  return SharedPreferences.getInstance();
});

final hydrationPrefsStoreProvider = FutureProvider<HydrationPrefsStore>((
  ref,
) async {
  final prefs = await ref.watch(sharedPreferencesProvider.future);
  return HydrationPrefsStore(prefs);
});

// ——— Domain contracts (injectable for tests) ———

final hydrationRepositoryProvider = FutureProvider<HydrationRepository>((
  ref,
) async {
  final store = await ref.watch(hydrationPrefsStoreProvider.future);
  return HydrationRepositoryImpl(store);
});

final widgetSyncRepositoryProvider = Provider<WidgetSyncRepository>((ref) {
  return HomeWidgetSyncRepository();
});

final admobServiceProvider = ChangeNotifierProvider<AdMobService>((ref) {
  final service = AdMobService();
  ref.onDispose(service.dispose);
  return service;
});

// ——— Application state ———

final hydrationNotifierProvider =
    AsyncNotifierProvider<HydrationNotifier, HydrationSnapshot>(
      HydrationNotifier.new,
    );
