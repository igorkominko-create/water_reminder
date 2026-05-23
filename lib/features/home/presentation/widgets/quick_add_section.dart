import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/glass_surface.dart';

class QuickAddSection extends StatelessWidget {
  const QuickAddSection({super.key, required this.onAdd});

  final ValueChanged<int> onAdd;

  @override
  Widget build(BuildContext context) {
    final colors = context.waterColors;

    return GlassSurface(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Add water',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: colors.deep,
                ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              for (var i = 0; i < AppConstants.quickAddMl.length; i++) ...[
                if (i > 0) const SizedBox(width: 10),
                Expanded(
                  child: _AddTile(
                    ml: AppConstants.quickAddMl[i],
                    onTap: () {
                      HapticFeedback.lightImpact();
                      onAdd(AppConstants.quickAddMl[i]);
                    },
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}

class _AddTile extends StatelessWidget {
  const _AddTile({required this.ml, required this.onTap});

  final int ml;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.waterColors;
    final icon = switch (ml) {
      <= 150 => Icons.local_cafe_outlined,
      <= 250 => Icons.water_drop_outlined,
      <= 350 => Icons.wine_bar_outlined,
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
                '$ml',
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: colors.deep,
                    ),
              ),
              Text(
                'ml',
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
