import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:water_reminder/app/water_app.dart';
import 'package:water_reminder/domain/hydration_state.dart';
import 'package:water_reminder/features/hydration/application/hydration_controller.dart';
import 'package:water_reminder/features/widget/widget_bridge.dart';

void main() {
  testWidgets('WaterApp shows title', (tester) async {
    SharedPreferences.setMockInitialValues({});

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          hydrationControllerProvider.overrideWith(_TestHydrationController.new),
          widgetBridgeProvider.overrideWithValue(_NoOpWidgetBridge()),
        ],
        child: const WaterApp(),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Water Reminder'), findsWidgets);
  });
}

class _TestHydrationController extends HydrationController {
  @override
  Future<HydrationState> build() async {
    return HydrationState(
      goalMl: 2000,
      todayMl: 0,
      todayKey: '2026-01-01',
    );
  }
}

class _NoOpWidgetBridge extends WidgetBridge {
  @override
  Future<void> init() async {}

  @override
  Future<void> sync(HydrationState state) async {}
}
