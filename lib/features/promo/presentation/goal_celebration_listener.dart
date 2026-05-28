import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/di/providers.dart';
import 'snapbite_goal_success_dialog.dart';

/// Shows the SnapBite promo dialog when [pendingSnapbiteGoalPromoProvider] is set.
class GoalCelebrationListener extends ConsumerStatefulWidget {
  const GoalCelebrationListener({super.key, required this.child});

  final Widget child;

  @override
  ConsumerState<GoalCelebrationListener> createState() =>
      _GoalCelebrationListenerState();
}

class _GoalCelebrationListenerState extends ConsumerState<GoalCelebrationListener> {
  @override
  Widget build(BuildContext context) {
    ref.listen<bool>(pendingSnapbiteGoalPromoProvider, (previous, next) {
      if (next != true) return;
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        if (!mounted) return;
        ref.read(pendingSnapbiteGoalPromoProvider.notifier).state = false;
        if (!context.mounted) return;
        await showSnapBiteGoalSuccessDialog(context);
      });
    });
    return widget.child;
  }
}
