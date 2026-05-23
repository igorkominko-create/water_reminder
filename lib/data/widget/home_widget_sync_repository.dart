import '../../domain/entities/hydration_snapshot.dart';
import '../../domain/repositories/widget_sync_repository.dart';
import 'widget_sync_helper.dart';

/// Syncs [HydrationSnapshot] to native widgets through the `home_widget` plugin.
class HomeWidgetSyncRepository implements WidgetSyncRepository {
  @override
  Future<void> initialize() => WidgetSyncHelper.ensureInitialized();

  @override
  Future<void> sync(HydrationSnapshot snapshot) =>
      WidgetSyncHelper.pushSnapshot(snapshot);
}
