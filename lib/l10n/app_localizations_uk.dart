// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Ukrainian (`uk`).
class AppLocalizationsUk extends AppLocalizations {
  AppLocalizationsUk([String locale = 'uk']) : super(locale);

  @override
  String get appName => 'Нагадування води';

  @override
  String get homeTitle => 'Нагадування води';

  @override
  String get settings => 'Налаштування';

  @override
  String get settingsTooltip => 'Налаштування';

  @override
  String mlToGo(int ml) {
    return 'Залишилось $ml мл';
  }

  @override
  String get goalReachedHeadline => 'Денну норму виконано';

  @override
  String get addWater => 'Додати воду';

  @override
  String get customAmountHint => 'Своя кількість (мл)';

  @override
  String get addCustom => 'Додати';

  @override
  String invalidAmountMessage(int min, int max) {
    return 'Введіть кількість від $min до $max мл';
  }

  @override
  String mlWithUnit(int ml) {
    return '$ml мл';
  }

  @override
  String get mlLabel => 'мл';

  @override
  String ofDailyGoal(int goalMl) {
    return 'з $goalMl мл';
  }

  @override
  String get widgetHint =>
      'Додайте віджет на головний або заблокований екран — він оновлюється, коли ви записуєте воду тут.';

  @override
  String get dailyGoalTitle => 'Денна норма (мл)';

  @override
  String get dailyGoalHint => '2000';

  @override
  String get saveGoal => 'Зберегти норму';

  @override
  String get invalidGoalMessage => 'Введіть норму від 250 до 10000 мл';

  @override
  String get resetTodayTitle => 'Скинути сьогодні?';

  @override
  String get resetTodayMessage =>
      'Очищає сьогоднішнє споживання. Віджети теж оновляться.';

  @override
  String get cancel => 'Скасувати';

  @override
  String get reset => 'Скинути';

  @override
  String get resetToday => 'Скинути сьогодні';

  @override
  String errorMessage(String error) {
    return 'Помилка: $error';
  }

  @override
  String get trackingUsageDescription =>
      'Це дозволить показувати релевантнішу рекламу та підтримувати безкоштовний додаток.';

  @override
  String get snapbitePromoTitle => 'Спробуйте SnapBite';

  @override
  String get snapbitePromoSubtitle =>
      'Ваш AI-помічник для харчування. Скануйте страви за секунди!';

  @override
  String get goalSuccessPromoTitle => 'Чудова робота!';

  @override
  String get goalSuccessPromoMessage =>
      'Денну норму виконано! 💧 Хочете покращити результати? Спробуйте AI-сканер їжі — SnapBite!';

  @override
  String get goalSuccessPromoDownload => 'Завантажити безкоштовно';

  @override
  String get goalSuccessPromoLater => 'Пізніше';
}
