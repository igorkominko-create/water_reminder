/// Volume conversion between milliliters (storage) and US fluid ounces (display).
abstract final class VolumeUnits {
  /// US fl oz per milliliter (1 fl oz ≈ 29.5735 ml).
  static const double flOzPerMl = 0.033814;

  static int mlToFlOz(int ml) => (ml * flOzPerMl).round();

  static int flOzToMl(int flOz) => (flOz / flOzPerMl).round();

  /// Metric quick-add presets (ml stored on tap).
  static const List<int> quickAddMl = [150, 250, 350, 500];

  /// Imperial quick-add presets (fl oz shown; converted to ml on tap).
  static const List<int> quickAddFlOz = [8, 12, 16, 24];

  static List<int> quickAddMlForTap({required bool isMetric}) {
    if (isMetric) return quickAddMl;
    return quickAddFlOz.map(flOzToMl).toList(growable: false);
  }

  static List<int> quickAddDisplayValues({required bool isMetric}) {
    return isMetric ? quickAddMl : quickAddFlOz;
  }
}
