import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_uk.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('uk'),
  ];

  /// Application display name
  ///
  /// In en, this message translates to:
  /// **'Water Reminder'**
  String get appName;

  /// No description provided for @homeTitle.
  ///
  /// In en, this message translates to:
  /// **'Water Reminder'**
  String get homeTitle;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @settingsTooltip.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingsTooltip;

  /// No description provided for @mlToGo.
  ///
  /// In en, this message translates to:
  /// **'{ml} ml to go'**
  String mlToGo(int ml);

  /// No description provided for @goalReachedHeadline.
  ///
  /// In en, this message translates to:
  /// **'Daily goal complete'**
  String get goalReachedHeadline;

  /// No description provided for @addWater.
  ///
  /// In en, this message translates to:
  /// **'Add water'**
  String get addWater;

  /// No description provided for @customAmountHint.
  ///
  /// In en, this message translates to:
  /// **'Custom amount (ml)'**
  String get customAmountHint;

  /// No description provided for @addCustom.
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get addCustom;

  /// No description provided for @invalidAmountMessage.
  ///
  /// In en, this message translates to:
  /// **'Enter an amount between {min} and {max} ml'**
  String invalidAmountMessage(int min, int max);

  /// No description provided for @mlWithUnit.
  ///
  /// In en, this message translates to:
  /// **'{ml} ml'**
  String mlWithUnit(int ml);

  /// No description provided for @mlLabel.
  ///
  /// In en, this message translates to:
  /// **'ml'**
  String get mlLabel;

  /// No description provided for @ofDailyGoal.
  ///
  /// In en, this message translates to:
  /// **'of {goalMl} ml'**
  String ofDailyGoal(int goalMl);

  /// No description provided for @widgetHint.
  ///
  /// In en, this message translates to:
  /// **'Add a widget on your Home or Lock Screen — it updates when you log water here.'**
  String get widgetHint;

  /// No description provided for @dailyGoalTitle.
  ///
  /// In en, this message translates to:
  /// **'Daily goal (ml)'**
  String get dailyGoalTitle;

  /// No description provided for @dailyGoalHint.
  ///
  /// In en, this message translates to:
  /// **'2000'**
  String get dailyGoalHint;

  /// No description provided for @saveGoal.
  ///
  /// In en, this message translates to:
  /// **'Save goal'**
  String get saveGoal;

  /// No description provided for @invalidGoalMessage.
  ///
  /// In en, this message translates to:
  /// **'Enter a goal between 250 and 10000 ml'**
  String get invalidGoalMessage;

  /// No description provided for @resetTodayTitle.
  ///
  /// In en, this message translates to:
  /// **'Reset today?'**
  String get resetTodayTitle;

  /// No description provided for @resetTodayMessage.
  ///
  /// In en, this message translates to:
  /// **'Clears today\'s intake. Widgets will update too.'**
  String get resetTodayMessage;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @reset.
  ///
  /// In en, this message translates to:
  /// **'Reset'**
  String get reset;

  /// No description provided for @resetToday.
  ///
  /// In en, this message translates to:
  /// **'Reset today'**
  String get resetToday;

  /// No description provided for @errorMessage.
  ///
  /// In en, this message translates to:
  /// **'Error: {error}'**
  String errorMessage(String error);

  /// iOS App Tracking Transparency prompt (also in InfoPlist.strings)
  ///
  /// In en, this message translates to:
  /// **'This allows us to show ads that are more relevant to you and support the free app.'**
  String get trackingUsageDescription;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'uk'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'uk':
      return AppLocalizationsUk();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
