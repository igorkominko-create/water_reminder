import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/app_constants.dart';

/// `true` = metric (ml), `false` = imperial (fl oz display).
class VolumeUnitNotifier extends Notifier<bool> {
  @override
  bool build() {
    _loadFromPrefs();
    return true;
  }

  Future<void> _loadFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final isMetric = prefs.getBool(AppConstants.prefIsMetric) ?? true;
    if (state != isMetric) {
      state = isMetric;
    }
  }

  Future<void> setMetric(bool isMetric) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(AppConstants.prefIsMetric, isMetric);
    state = isMetric;
  }
}

final isMetricProvider =
    NotifierProvider<VolumeUnitNotifier, bool>(VolumeUnitNotifier.new);
