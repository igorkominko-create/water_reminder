import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart';

import '../../l10n/app_localizations.dart';

/// English (default) and Ukrainian localization.
abstract final class AppLocale {
  static const Locale english = Locale('en');
  static const Locale ukrainian = Locale('uk');

  static const List<Locale> supportedLocales = [english, ukrainian];

  static const List<LocalizationsDelegate<dynamic>> delegates = [
    AppLocalizations.delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
  ];

  /// Syncs [Intl] with the active app [locale] (call from [MaterialApp] builder).
  static void applyIntlLocale(Locale locale) {
    final code = locale.languageCode == 'uk' ? 'uk_UA' : 'en_US';
    Intl.defaultLocale = code;
  }

  /// Startup default before [MaterialApp] builds (follows device language).
  static void configure() {
    final device = WidgetsBinding.instance.platformDispatcher.locale;
    applyIntlLocale(resolveLocale(device));
  }

  /// Picks en or uk; everything else falls back to English.
  static Locale resolveLocale(Locale? locale) {
    if (locale != null && locale.languageCode == 'uk') {
      return ukrainian;
    }
    return english;
  }

  static Locale? localeResolutionCallback(
    Locale? locale,
    Iterable<Locale> supported,
  ) {
    return resolveLocale(locale);
  }
}
