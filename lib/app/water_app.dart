import 'package:flutter/material.dart';

import '../core/i18n/app_locale.dart';
import '../core/i18n/app_strings.dart';
import '../core/theme/app_theme.dart';
import '../features/home/presentation/home_screen.dart';

class WaterApp extends StatelessWidget {
  const WaterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppStrings.appName,
      debugShowCheckedModeBanner: false,
      locale: AppLocale.english,
      supportedLocales: AppLocale.supportedLocales,
      localizationsDelegates: AppLocale.delegates,
      theme: AppTheme.light(),
      home: const HomeScreen(),
    );
  }
}
