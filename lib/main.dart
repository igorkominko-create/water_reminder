import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app/water_app.dart';
import 'core/di/providers.dart';
import 'core/i18n/app_locale.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  AppLocale.configure();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // App Group must be set before any widget read/write (iOS).
  final container = ProviderContainer();
  await container.read(widgetSyncRepositoryProvider).initialize();

  runApp(
    UncontrolledProviderScope(
      container: container,
      child: const WaterApp(),
    ),
  );
}
