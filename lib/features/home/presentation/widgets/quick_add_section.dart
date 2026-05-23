import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/glass_surface.dart';
import '../../../../l10n/app_localizations.dart';

class QuickAddSection extends StatefulWidget {
  const QuickAddSection({super.key, required this.onAdd});

  final ValueChanged<int> onAdd;

  @override
  State<QuickAddSection> createState() => _QuickAddSectionState();
}

class _QuickAddSectionState extends State<QuickAddSection> {
  final _customController = TextEditingController();

  @override
  void dispose() {
    _customController.dispose();
    super.dispose();
  }

  void _submitCustom() {
    final l10n = AppLocalizations.of(context);
    final parsed = int.tryParse(_customController.text.trim());
    if (parsed == null ||
        parsed < AppConstants.minAddMl ||
        parsed > AppConstants.maxAddMl) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            l10n.invalidAmountMessage(
              AppConstants.minAddMl,
              AppConstants.maxAddMl,
            ),
          ),
        ),
      );
      return;
    }
    HapticFeedback.lightImpact();
    widget.onAdd(parsed);
    _customController.clear();
    FocusScope.of(context).unfocus();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final colors = context.waterColors;

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
              for (var i = 0; i < AppConstants.quickAddMl.length; i++) ...[
                if (i > 0) const SizedBox(width: 10),
                Expanded(
                  child: _AddTile(
                    ml: AppConstants.quickAddMl[i],
                    mlLabel: l10n.mlLabel,
                    onTap: () {
                      HapticFeedback.lightImpact();
                      widget.onAdd(AppConstants.quickAddMl[i]);
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
                  onSubmitted: (_) => _submitCustom(),
                  decoration: InputDecoration(
                    hintText: l10n.customAmountHint,
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
                onPressed: _submitCustom,
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
    required this.ml,
    required this.mlLabel,
    required this.onTap,
  });

  final int ml;
  final String mlLabel;
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
                mlLabel,
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
