import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/di/providers.dart';
import '../../../core/i18n/app_strings.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  late final TextEditingController _goalController;
  bool _goalFieldInitialized = false;

  @override
  void initState() {
    super.initState();
    _goalController = TextEditingController();
  }

  @override
  void dispose() {
    _goalController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final async = ref.watch(hydrationNotifierProvider);

    return Scaffold(
      appBar: AppBar(title: const Text(AppStrings.settings)),
      body: async.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text(AppStrings.errorMessage(e))),
        data: (snapshot) {
          if (!_goalFieldInitialized) {
            _goalController.text = '${snapshot.goalMl}';
            _goalFieldInitialized = true;
          }
          return ListView(
            padding: const EdgeInsets.all(24),
            children: [
              Text(
                AppStrings.dailyGoalTitle,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _goalController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: AppStrings.dailyGoalHint,
                ),
              ),
              const SizedBox(height: 12),
              FilledButton(
                onPressed: () {
                  final parsed = int.tryParse(_goalController.text.trim());
                  if (parsed == null || parsed < 250 || parsed > 10000) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(AppStrings.invalidGoalMessage),
                      ),
                    );
                    return;
                  }
                  ref.read(hydrationNotifierProvider.notifier).setGoal(parsed);
                  Navigator.of(context).pop();
                },
                child: const Text(AppStrings.saveGoal),
              ),
              const SizedBox(height: 32),
              OutlinedButton(
                onPressed: () async {
                  final ok = await showDialog<bool>(
                    context: context,
                    builder: (ctx) => AlertDialog(
                      title: const Text(AppStrings.resetTodayTitle),
                      content: const Text(AppStrings.resetTodayMessage),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(ctx, false),
                          child: const Text(AppStrings.cancel),
                        ),
                        FilledButton(
                          onPressed: () => Navigator.pop(ctx, true),
                          child: const Text(AppStrings.reset),
                        ),
                      ],
                    ),
                  );
                  if (ok == true && context.mounted) {
                    await ref
                        .read(hydrationNotifierProvider.notifier)
                        .resetToday();
                    if (context.mounted) Navigator.of(context).pop();
                  }
                },
                child: const Text(AppStrings.resetToday),
              ),
            ],
          );
        },
      ),
    );
  }
}
