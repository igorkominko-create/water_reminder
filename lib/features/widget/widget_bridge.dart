import 'package:home_widget/home_widget.dart';

import '../../core/constants/app_constants.dart';
import '../../domain/hydration_state.dart';

/// Pushes hydration snapshot to native home / lock screen widgets.
class WidgetBridge {
  Future<void> sync(HydrationState state) async {
    await HomeWidget.setAppGroupId(AppConstants.widgetGroupId);
    await HomeWidget.saveWidgetData<int>(
      AppConstants.widgetGoalMl,
      state.goalMl,
    );
    await HomeWidget.saveWidgetData<int>(
      AppConstants.widgetTodayMl,
      state.todayMl,
    );
    await HomeWidget.saveWidgetData<double>(
      AppConstants.widgetProgress,
      state.progress,
    );
    await HomeWidget.updateWidget(
      name: AppConstants.androidWidgetName,
      iOSName: AppConstants.iosWidgetName,
    );
  }

  Future<void> init() async {
    await HomeWidget.setAppGroupId(AppConstants.widgetGroupId);
  }
}
