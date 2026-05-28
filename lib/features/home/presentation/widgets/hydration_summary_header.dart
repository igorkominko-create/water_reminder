import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../domain/entities/hydration_snapshot.dart';
import '../../../../l10n/app_localizations.dart';

class HydrationSummaryHeader extends StatelessWidget {
  const HydrationSummaryHeader({super.key, required this.snapshot});

  final HydrationSnapshot snapshot;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final colors = context.waterColors;
    final locale = Localizations.localeOf(context).toString();
    final dateLabel =
        DateFormat('EEEE, d MMMM', locale).format(DateTime.now());

    final headline = snapshot.goalReached
        ? l10n.goalReachedHeadline
        : l10n.mlToGo(snapshot.remainingMl);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          dateLabel,
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
                color: colors.mid,
                letterSpacing: 0.4,
              ),
        ),
        const SizedBox(height: 8),
        Text(
          headline,
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w700,
                color: colors.deep,
                height: 1.15,
              ),
        ),
      ],
    );
  }
}
