import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/app_theme.dart';
import '../../hydration/application/hydration_controller.dart';
import '../../settings/presentation/settings_screen.dart';
import 'widgets/quick_add_buttons.dart';
import 'widgets/water_progress_ring.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final async = ref.watch(hydrationControllerProvider);
    final colors = context.waterColors;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Water Reminder'),
        actions: [
          IconButton(
            icon: const Icon(Icons.tune_rounded),
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute<void>(
                builder: (_) => const SettingsScreen(),
              ),
            ),
          ),
        ],
      ),
      body: async.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
        data: (state) {
          final subtitle = state.goalReached
              ? 'Goal reached — great hydration!'
              : '${state.remainingMl} ml left today';

          return SafeArea(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(24, 8, 24, 32),
              children: [
                Text(
                  subtitle,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: colors.mid,
                      ),
                ),
                const SizedBox(height: 28),
                Center(
                  child: WaterProgressRing(
                    progress: state.progress,
                    todayMl: state.todayMl,
                    goalMl: state.goalMl,
                  ),
                ),
                const SizedBox(height: 36),
                QuickAddButtons(
                  onAdd: (ml) => ref
                      .read(hydrationControllerProvider.notifier)
                      .addWater(ml),
                ),
                const SizedBox(height: 28),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Row(
                      children: [
                        Icon(Icons.widgets_outlined, color: colors.mid),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Text(
                            'Add the Water widget from your home or lock screen '
                            'to track progress at a glance.',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
