import 'package:flutter/material.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_theme.dart';

class QuickAddButtons extends StatelessWidget {
  const QuickAddButtons({super.key, required this.onAdd});

  final ValueChanged<int> onAdd;

  @override
  Widget build(BuildContext context) {
    final colors = context.waterColors;

    return Wrap(
      spacing: 10,
      runSpacing: 10,
      alignment: WrapAlignment.center,
      children: [
        for (final ml in AppConstants.quickAddMl)
          _QuickChip(
            label: '+$ml ml',
            color: colors.foam,
            foreground: colors.deep,
            onTap: () => onAdd(ml),
          ),
      ],
    );
  }
}

class _QuickChip extends StatelessWidget {
  const _QuickChip({
    required this.label,
    required this.color,
    required this.foreground,
    required this.onTap,
  });

  final String label;
  final Color color;
  final Color foreground;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: color,
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
          child: Text(
            label,
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: foreground,
                  fontWeight: FontWeight.w600,
                ),
          ),
        ),
      ),
    );
  }
}
