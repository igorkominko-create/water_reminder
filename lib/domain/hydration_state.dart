class HydrationState {
  const HydrationState({
    required this.goalMl,
    required this.todayMl,
    required this.todayKey,
  });

  final int goalMl;
  final int todayMl;
  final String todayKey;

  double get progress => goalMl <= 0 ? 0 : (todayMl / goalMl).clamp(0.0, 1.0);

  int get remainingMl => (goalMl - todayMl).clamp(0, goalMl);

  bool get goalReached => todayMl >= goalMl;

  HydrationState copyWith({
    int? goalMl,
    int? todayMl,
    String? todayKey,
  }) {
    return HydrationState(
      goalMl: goalMl ?? this.goalMl,
      todayMl: todayMl ?? this.todayMl,
      todayKey: todayKey ?? this.todayKey,
    );
  }
}
