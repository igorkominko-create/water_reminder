import '../entities/hydration_snapshot.dart';

/// Pushes hydration data to native home / lock screen widgets.
abstract class WidgetSyncRepository {
  Future<void> initialize();

  Future<void> sync(HydrationSnapshot snapshot);
}
