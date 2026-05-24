import 'package:flutter/material.dart';

import '../core/i18n/app_locale.dart';
import '../core/theme/app_theme.dart';
import '../features/home/presentation/home_screen.dart';
import '../l10n/app_localizations.dart';

class WaterApp extends StatelessWidget {
  const WaterApp({super.key, this.locale});

  /// When set (e.g. in tests), overrides [localeResolutionCallback].
  final Locale? locale;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateTitle: (context) => AppLocalizations.of(context).appName,
      debugShowCheckedModeBanner: false,
      locale: locale,
      supportedLocales: AppLocale.supportedLocales,
      localizationsDelegates: AppLocale.delegates,
      localeResolutionCallback: locale != null
          ? null
          : AppLocale.localeResolutionCallback,
      builder: (context, child) {
        AppLocale.applyIntlLocale(Localizations.localeOf(context));
        return child ?? const SizedBox.shrink();
      },
      theme: AppTheme.light(),
      home: const HomeScreen(),
    );
  }
}
