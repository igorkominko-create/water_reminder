/// Immutable hydration state for one calendar day.
class HydrationSnapshot {
  const HydrationSnapshot({
    required this.goalMl,
    required this.todayMl,
    required this.todayKey,
  });

  final int goalMl;
  final int todayMl;

  /// `yyyy-MM-dd` for the device local date.
  final String todayKey;

  double get progress =>
      goalMl <= 0 ? 0 : (todayMl / goalMl).clamp(0.0, 1.0);

  int get remainingMl => (goalMl - todayMl).clamp(0, goalMl);

  int get percent => (progress * 100).round();

  bool get goalReached => todayMl >= goalMl;

  HydrationSnapshot copyWith({
    int? goalMl,
    int? todayMl,
    String? todayKey,
  }) {
    return HydrationSnapshot(
      goalMl: goalMl ?? this.goalMl,
      todayMl: todayMl ?? this.todayMl,
      todayKey: todayKey ?? this.todayKey,
    );
  }
}
