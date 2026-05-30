import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/app_constants.dart';
import '../../../core/di/providers.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/units/volume_format.dart';
import '../../../core/units/volume_unit_notifier.dart';
import '../../../core/units/volume_units.dart';
import '../../../core/widgets/glass_surface.dart';
import '../../../l10n/app_localizations.dart';
import '../../promo/presentation/snapbite_promo_card.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  late final TextEditingController _goalController;
  bool _goalFieldInitialized = false;
  bool? _lastIsMetric;

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

  void _syncGoalField(int goalMl, bool isMetric) {
    final format = VolumeFormat(
      l10n: AppLocalizations.of(context),
      isMetric: isMetric,
    );
    _goalController.text = '${format.displayValueFromMl(goalMl)}';
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final async = ref.watch(hydrationNotifierProvider);
    final isMetric = ref.watch(isMetricProvider);
    final colors = context.waterColors;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.settings)),
      body: async.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text(l10n.errorMessage('$e'))),
        data: (snapshot) {
          if (!_goalFieldInitialized || _lastIsMetric != isMetric) {
            _syncGoalField(snapshot.goalMl, isMetric);
            _goalFieldInitialized = true;
            _lastIsMetric = isMetric;
          }
          final format = VolumeFormat(l10n: l10n, isMetric: isMetric);

          return ListView(
            padding: const EdgeInsets.all(24),
            children: [
              GlassSurface(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.unitsTitle,
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: colors.deep,
                          ),
                    ),
                    const SizedBox(height: 12),
                    SegmentedButton<bool>(
                      segments: [
                        ButtonSegment<bool>(
                          value: true,
                          label: Text(l10n.mlLabel),
                        ),
                        ButtonSegment<bool>(
                          value: false,
                          label: Text(l10n.flOzLabel),
                        ),
                      ],
                      selected: {isMetric},
                      onSelectionChanged: (selection) {
                        final next = selection.first;
                        ref.read(isMetricProvider.notifier).setMetric(next);
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              Text(
                isMetric ? l10n.dailyGoalTitle : l10n.dailyGoalTitleFlOz,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _goalController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  hintText: isMetric
                      ? l10n.dailyGoalHint
                      : '${VolumeUnits.mlToFlOz(AppConstants.defaultGoalMl)}',
                ),
              ),
              const SizedBox(height: 12),
              FilledButton(
                onPressed: () {
                  final goalMl = format.parseInputToMl(_goalController.text);
                  if (goalMl == null ||
                      goalMl < 250 ||
                      goalMl > AppConstants.maxAddMl) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          isMetric
                              ? l10n.invalidGoalMessage
                              : l10n.invalidGoalMessageFlOz,
                        ),
                      ),
                    );
                    return;
                  }
                  ref.read(hydrationNotifierProvider.notifier).setGoal(goalMl);
                  Navigator.of(context).pop();
                },
                child: Text(l10n.saveGoal),
              ),
              const SizedBox(height: 28),
              const SnapBitePromoCard(),
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
