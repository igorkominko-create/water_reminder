import 'package:flutter/material.dart';

import '../../../core/promo/snapbite_store_launcher.dart';
import '../../../core/theme/app_theme.dart';
import '../../../l10n/app_localizations.dart';

/// Active SnapBite cross-promo after the daily hydration goal is reached.
Future<void> showSnapBiteGoalSuccessDialog(BuildContext context) {
  final colors = context.waterColors;

  return showDialog<void>(
    context: context,
    barrierDismissible: true,
    builder: (ctx) {
      final dialogL10n = AppLocalizations.of(ctx);
      return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        title: Text(
          dialogL10n.goalSuccessPromoTitle,
          textAlign: TextAlign.center,
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            DecoratedBox(
              decoration: BoxDecoration(
                color: colors.foam,
                shape: BoxShape.circle,
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Icon(Icons.water_drop_rounded, size: 40, color: colors.mid),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              dialogL10n.goalSuccessPromoMessage,
              textAlign: TextAlign.center,
              style: Theme.of(ctx).textTheme.bodyMedium?.copyWith(height: 1.45),
            ),
          ],
        ),
        actionsAlignment: MainAxisAlignment.center,
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: Text(dialogL10n.goalSuccessPromoLater),
          ),
          FilledButton(
            onPressed: () async {
              await openSnapBiteStoreListing();
              if (ctx.mounted) Navigator.of(ctx).pop();
            },
            child: Text(dialogL10n.goalSuccessPromoDownload),
          ),
        ],
      );
    },
  );
}
