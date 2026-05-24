import 'package:home_widget/home_widget.dart';

import '../../core/constants/app_constants.dart';
import '../../domain/entities/hydration_snapshot.dart';
import 'widget_data_keys.dart';

/// Low-level bridge to `home_widget` — used by [HomeWidgetSyncRepository].
///
/// Call [pushSnapshot] after every hydration change so iOS WidgetKit /
/// Android AppWidget reload immediately.
abstract final class WidgetSyncHelper {
  static Future<void> ensureInitialized() async {
    await HomeWidget.setAppGroupId(AppConstants.widgetGroupId);
  }

  static Future<void> pushSnapshot(HydrationSnapshot snapshot) async {
    await ensureInitialized();

    await Future.wait([
      HomeWidget.saveWidgetData<int>(WidgetDataKeys.goalMl, snapshot.goalMl),
      HomeWidget.saveWidgetData<int>(WidgetDataKeys.todayMl, snapshot.todayMl),
      HomeWidget.saveWidgetData<double>(
        WidgetDataKeys.progress,
        snapshot.progress,
      ),
      HomeWidget.saveWidgetData<int>(WidgetDataKeys.percent, snapshot.percent),
      HomeWidget.saveWidgetData<int>(
        WidgetDataKeys.remainingMl,
        snapshot.remainingMl,
      ),
      HomeWidget.saveWidgetData<bool>(
        WidgetDataKeys.goalReached,
        snapshot.goalReached,
      ),
      HomeWidget.saveWidgetData<String>(
        WidgetDataKeys.updatedAt,
        DateTime.now().toIso8601String(),
      ),
    ]);

    // `kind` in Swift must be exactly [AppConstants.iosWidgetName].
    await HomeWidget.updateWidget(
      name: AppConstants.androidWidgetName,
      iOSName: AppConstants.iosWidgetName,
      qualifiedAndroidName: 'com.ihorkominko.waterreminder.WaterWidgetProvider',
    );
  }
}
