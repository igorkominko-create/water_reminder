import 'package:flutter_test/flutter_test.dart';
import 'package:water_reminder/data/widget/widget_data_keys.dart';
import 'package:water_reminder/domain/entities/hydration_snapshot.dart';

void main() {
  test('snapshot percent matches widget percent key semantics', () {
    const s = HydrationSnapshot(goalMl: 2000, todayMl: 500, todayKey: 'x');
    expect(s.percent, 25);
    expect(WidgetDataKeys.percent, 'percent');
  });
}
