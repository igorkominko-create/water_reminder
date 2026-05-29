import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:water_reminder/core/i18n/app_locale.dart';
import 'package:water_reminder/app/water_app.dart';
import 'package:water_reminder/core/di/providers.dart';
import 'package:water_reminder/domain/entities/hydration_snapshot.dart';
import 'package:water_reminder/domain/repositories/widget_sync_repository.dart';
import 'package:water_reminder/core/theme/app_theme.dart';
import 'package:water_reminder/features/home/presentation/home_screen.dart';
import 'package:water_reminder/features/hydration/application/hydration_notifier.dart';

void main() {
  testWidgets('Home shows hydration headline', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          hydrationNotifierProvider.overrideWith(_TestHydrationNotifier.new),
          widgetSyncRepositoryProvider.overrideWithValue(_NoOpWidgetSync()),
        ],
        child: const WaterApp(),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Water Reminder'), findsWidgets);
    expect(find.text('2000 ml to go'), findsOneWidget);
  });

  testWidgets('Home shows Ukrainian when locale is uk', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          hydrationNotifierProvider.overrideWith(_TestHydrationNotifier.new),
          widgetSyncRepositoryProvider.overrideWithValue(_NoOpWidgetSync()),
        ],
        child: MaterialApp(
          locale: AppLocale.ukrainian,
          supportedLocales: AppLocale.supportedLocales,
          localizationsDelegates: AppLocale.delegates,
          theme: AppTheme.light(),
          home: const HomeScreen(),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Нагадування води'), findsWidgets);
    expect(find.text('Залишилось 2000 мл'), findsOneWidget);
  });
}

class _TestHydrationNotifier extends HydrationNotifier {
  @override
  Future<HydrationSnapshot> build() async {
    return const HydrationSnapshot(
      goalMl: 2000,
      todayMl: 0,
      todayKey: '2026-01-01',
    );
  }
}

class _NoOpWidgetSync implements WidgetSyncRepository {
  @override
  Future<void> initialize() async {}

  @override
  Future<void> sync(HydrationSnapshot snapshot) async {}
}
