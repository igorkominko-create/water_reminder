import 'package:flutter_test/flutter_test.dart';
import 'package:water_reminder/core/units/volume_units.dart';

void main() {
  group('VolumeUnits', () {
    test('mlToFlOz rounds common presets', () {
      expect(VolumeUnits.mlToFlOz(250), 8);
      expect(VolumeUnits.mlToFlOz(500), 17);
      expect(VolumeUnits.mlToFlOz(2000), 68);
    });

    test('flOzToMl converts back for quick-add taps', () {
      expect(VolumeUnits.flOzToMl(8), 237);
      expect(VolumeUnits.flOzToMl(16), 473);
      expect(VolumeUnits.flOzToMl(24), 710);
    });

    test('quickAdd imperial presets map to ml on tap', () {
      final ml = VolumeUnits.quickAddMlForTap(isMetric: false);
      expect(ml, [237, 355, 473, 710]);
    });
  });
}
