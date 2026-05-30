import '../../l10n/app_localizations.dart';
import 'volume_units.dart';

/// Formats stored milliliters for the active unit system.
class VolumeFormat {
  const VolumeFormat({
    required this.l10n,
    required this.isMetric,
  });

  final AppLocalizations l10n;
  final bool isMetric;

  String volume(int ml) =>
      isMetric ? l10n.mlWithUnit(ml) : l10n.flOzWithUnit(VolumeUnits.mlToFlOz(ml));

  String volumeToGo(int remainingMl) => isMetric
      ? l10n.mlToGo(remainingMl)
      : l10n.flOzToGo(VolumeUnits.mlToFlOz(remainingMl));

  String ofDailyGoal(int goalMl) => isMetric
      ? l10n.ofDailyGoal(goalMl)
      : l10n.ofDailyGoalFlOz(VolumeUnits.mlToFlOz(goalMl));

  /// Parses user input in the active unit; returns ml, or null if invalid.
  int? parseInputToMl(String raw) {
    final parsed = int.tryParse(raw.trim());
    if (parsed == null) return null;
    return isMetric ? parsed : VolumeUnits.flOzToMl(parsed);
  }

  int displayValueFromMl(int ml) =>
      isMetric ? ml : VolumeUnits.mlToFlOz(ml);

  String unitLabel() => isMetric ? l10n.mlLabel : l10n.flOzLabel;
}
