import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/di/providers.dart';
import '../../../domain/entities/hydration_snapshot.dart';

/// Orchestrates hydration use cases and keeps widgets in sync.
class HydrationNotifier extends AsyncNotifier<HydrationSnapshot> {
  @override
  Future<HydrationSnapshot> build() async {
    final repo = await ref.watch(hydrationRepositoryProvider.future);
    final widgets = ref.read(widgetSyncRepositoryProvider);
    await widgets.initialize();
    final snapshot = repo.load();
    await widgets.sync(snapshot);
    return snapshot;
  }

  Future<void> addWater(int ml) async {
    final repo = await ref.read(hydrationRepositoryProvider.future);
    final widgets = ref.read(widgetSyncRepositoryProvider);
    final previous = state.valueOrNull;
    final next = await repo.addWater(ml);
    state = AsyncData(next);
    await widgets.sync(next);

    final crossedGoal =
        previous != null && !previous.goalReached && next.goalReached;
    if (crossedGoal) {
      await ref.read(admobServiceProvider).onGoalReached(next.todayKey);
    }
  }

  Future<void> setGoal(int goalMl) async {
    final repo = await ref.read(hydrationRepositoryProvider.future);
    final widgets = ref.read(widgetSyncRepositoryProvider);
    final next = await repo.setGoal(goalMl);
    state = AsyncData(next);
    await widgets.sync(next);
  }

  Future<void> resetToday() async {
    final repo = await ref.read(hydrationRepositoryProvider.future);
    final widgets = ref.read(widgetSyncRepositoryProvider);
    final next = await repo.resetToday();
    state = AsyncData(next);
    await widgets.sync(next);
  }
}
