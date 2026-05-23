import '../entities/hydration_snapshot.dart';

abstract class HydrationRepository {
  HydrationSnapshot load();

  Future<HydrationSnapshot> addWater(int ml);

  Future<HydrationSnapshot> setGoal(int goalMl);

  Future<HydrationSnapshot> resetToday();
}
