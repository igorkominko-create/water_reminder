import '../../domain/entities/hydration_snapshot.dart';
import '../../domain/repositories/hydration_repository.dart';
import '../local/hydration_prefs_store.dart';

class HydrationRepositoryImpl implements HydrationRepository {
  HydrationRepositoryImpl(this._store);

  final HydrationPrefsStore _store;

  @override
  HydrationSnapshot load() {
    final todayKey = HydrationPrefsStore.todayKey();
    return HydrationSnapshot(
      goalMl: _store.readGoalMl(),
      todayMl: _store.readTodayMl(todayKey),
      todayKey: todayKey,
    );
  }

  @override
  Future<HydrationSnapshot> addWater(int ml) async {
    final todayKey = HydrationPrefsStore.todayKey();
    final nextMl = _store.readTodayMl(todayKey) + ml;
    await _store.writeToday(todayKey, nextMl);
    return load();
  }

  @override
  Future<HydrationSnapshot> setGoal(int goalMl) async {
    await _store.writeGoalMl(goalMl);
    return load();
  }

  @override
  Future<HydrationSnapshot> resetToday() async {
    final todayKey = HydrationPrefsStore.todayKey();
    await _store.writeToday(todayKey, 0);
    return load();
  }
}
