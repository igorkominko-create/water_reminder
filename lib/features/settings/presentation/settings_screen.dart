import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/di/providers.dart';
import '../../../l10n/app_localizations.dart';

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
    final l10n = AppLocalizations.of(context);
    final async = ref.watch(hydrationNotifierProvider);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.settings)),
      body: async.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text(l10n.errorMessage('$e'))),
        data: (snapshot) {
          if (!_goalFieldInitialized) {
            _goalController.text = '${snapshot.goalMl}';
            _goalFieldInitialized = true;
          }
          return ListView(
            padding: const EdgeInsets.all(24),
            children: [
              Text(
                l10n.dailyGoalTitle,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _goalController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  hintText: l10n.dailyGoalHint,
                ),
              ),
              const SizedBox(height: 12),
              FilledButton(
                onPressed: () {
                  final parsed = int.tryParse(_goalController.text.trim());
                  if (parsed == null || parsed < 250 || parsed > 10000) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(l10n.invalidGoalMessage)),
                    );
                    return;
                  }
                  ref.read(hydrationNotifierProvider.notifier).setGoal(parsed);
                  Navigator.of(context).pop();
                },
                child: Text(l10n.saveGoal),
              ),
              const SizedBox(height: 32),
              OutlinedButton(
                onPressed: () async {
                  final ok = await showDialog<bool>(
                    context: context,
                    builder: (ctx) {
                      final dialogL10n = AppLocalizations.of(ctx);
                      return AlertDialog(
                        title: Text(dialogL10n.resetTodayTitle),
                        content: Text(dialogL10n.resetTodayMessage),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(ctx, false),
                            child: Text(dialogL10n.cancel),
                          ),
                          FilledButton(
                            onPressed: () => Navigator.pop(ctx, true),
                            child: Text(dialogL10n.reset),
                          ),
                        ],
                      );
                    },
                  );
                  if (ok == true && context.mounted) {
                    await ref
                        .read(hydrationNotifierProvider.notifier)
                        .resetToday();
                    if (context.mounted) Navigator.of(context).pop();
                  }
                },
                child: Text(l10n.resetToday),
              ),
            ],
          );
        },
      ),
    );
  }
}
