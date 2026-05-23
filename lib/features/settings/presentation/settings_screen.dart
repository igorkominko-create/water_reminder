import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../hydration/application/hydration_controller.dart';

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
    final async = ref.watch(hydrationControllerProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: async.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
        data: (state) {
          if (!_goalFieldInitialized) {
            _goalController.text = '${state.goalMl}';
            _goalFieldInitialized = true;
          }
          return ListView(
          padding: const EdgeInsets.all(24),
          children: [
            Text(
              'Daily goal (ml)',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _goalController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: '2000',
              ),
            ),
            const SizedBox(height: 12),
            FilledButton(
              onPressed: () {
                final parsed = int.tryParse(_goalController.text.trim());
                if (parsed == null || parsed < 250 || parsed > 10000) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Enter a goal between 250 and 10000 ml'),
                    ),
                  );
                  return;
                }
                ref.read(hydrationControllerProvider.notifier).setGoal(parsed);
                Navigator.of(context).pop();
              },
              child: const Text('Save goal'),
            ),
            const SizedBox(height: 32),
            OutlinedButton(
              onPressed: () async {
                final ok = await showDialog<bool>(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    title: const Text('Reset today?'),
                    content: const Text(
                      'Clears today’s intake. This cannot be undone.',
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(ctx, false),
                        child: const Text('Cancel'),
                      ),
                      FilledButton(
                        onPressed: () => Navigator.pop(ctx, true),
                        child: const Text('Reset'),
                      ),
                    ],
                  ),
                );
                if (ok == true && context.mounted) {
                  await ref
                      .read(hydrationControllerProvider.notifier)
                      .resetToday();
                  if (context.mounted) Navigator.of(context).pop();
                }
              },
              child: const Text('Reset today'),
            ),
            const SizedBox(height: 24),
            Text(
              'Bundle IDs\n'
              'iOS: com.nexushealthlabs.waterreminder\n'
              'Android: com.ihorkominko.waterreminder',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        );
        },
      ),
    );
  }
}
