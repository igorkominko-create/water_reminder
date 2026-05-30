import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/units/volume_format.dart';
import '../../../../core/units/volume_unit_notifier.dart';
import '../../../../core/units/volume_units.dart';
import '../../../../core/widgets/glass_surface.dart';
import '../../../../l10n/app_localizations.dart';

class QuickAddSection extends ConsumerStatefulWidget {
  const QuickAddSection({super.key, required this.onAdd});

  final ValueChanged<int> onAdd;

  @override
  ConsumerState<QuickAddSection> createState() => _QuickAddSectionState();
}

class _QuickAddSectionState extends ConsumerState<QuickAddSection> {
  final _customController = TextEditingController();

  @override
  void dispose() {
    _customController.dispose();
    super.dispose();
  }

  void _submitCustom(bool isMetric) {
    final l10n = AppLocalizations.of(context);
    final format = VolumeFormat(l10n: l10n, isMetric: isMetric);
    final ml = format.parseInputToMl(_customController.text);
    if (ml == null ||
        ml < AppConstants.minAddMl ||
        ml > AppConstants.maxAddMl) {
      final minDisplay = isMetric
          ? AppConstants.minAddMl
          : VolumeUnits.mlToFlOz(AppConstants.minAddMl);
      final maxDisplay = isMetric
          ? AppConstants.maxAddMl
          : VolumeUnits.mlToFlOz(AppConstants.maxAddMl);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            isMetric
                ? l10n.invalidAmountMessage(minDisplay, maxDisplay)
                : l10n.invalidAmountMessageFlOz(minDisplay, maxDisplay),
          ),
        ),
      );
      return;
    }
    HapticFeedback.lightImpact();
    widget.onAdd(ml);
    _customController.clear();
    FocusScope.of(context).unfocus();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final colors = context.waterColors;
    final isMetric = ref.watch(isMetricProvider);
    final format = VolumeFormat(l10n: l10n, isMetric: isMetric);
    final displayValues = VolumeUnits.quickAddDisplayValues(isMetric: isMetric);
    final tapMlValues = VolumeUnits.quickAddMlForTap(isMetric: isMetric);

    return GlassSurface(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            l10n.addWater,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: colors.deep,
                ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              for (var i = 0; i < displayValues.length; i++) ...[
                if (i > 0) const SizedBox(width: 10),
                Expanded(
                  child: _AddTile(
                    displayValue: displayValues[i],
                    unitLabel: format.unitLabel(),
                    mlForIcon: tapMlValues[i],
                    onTap: () {
                      HapticFeedback.lightImpact();
                      widget.onAdd(tapMlValues[i]);
                    },
                  ),
                ),
              ],
            ],
          ),
          const SizedBox(height: 14),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: TextField(
                  controller: _customController,
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.done,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  onSubmitted: (_) => _submitCustom(isMetric),
                  decoration: InputDecoration(
                    hintText: isMetric
                        ? l10n.customAmountHint
                        : l10n.customAmountHintFlOz,
                    filled: true,
                    fillColor: colors.foam,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 14,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              FilledButton(
                onPressed: () => _submitCustom(isMetric),
                child: Text(l10n.addCustom),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _AddTile extends StatelessWidget {
  const _AddTile({
    required this.displayValue,
    required this.unitLabel,
    required this.mlForIcon,
    required this.onTap,
  });

  final int displayValue;
  final String unitLabel;
  final int mlForIcon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.waterColors;
    final icon = switch (mlForIcon) {
      <= 180 => Icons.local_cafe_outlined,
      <= 280 => Icons.water_drop_outlined,
      <= 400 => Icons.wine_bar_outlined,
      _ => Icons.sports_bar_outlined,
    };

    return Material(
      color: colors.foam,
      borderRadius: BorderRadius.circular(18),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(18),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 14),
          child: Column(
            children: [
              Icon(icon, color: colors.mid, size: 22),
              const SizedBox(height: 6),
              Text(
                '$displayValue',
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: colors.deep,
                    ),
              ),
              Text(
                unitLabel,
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: colors.deep.withValues(alpha: 0.5),
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
