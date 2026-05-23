import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart';

/// Forces English UI regardless of device language.
abstract final class AppLocale {
  static const Locale english = Locale('en', 'US');

  static const List<LocalizationsDelegate<dynamic>> delegates = [
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
  ];

  static const List<Locale> supportedLocales = [english];

  /// Call once at startup so [DateFormat] uses English month/day names.
  static void configure() {
    Intl.defaultLocale = 'en_US';
  }
}
