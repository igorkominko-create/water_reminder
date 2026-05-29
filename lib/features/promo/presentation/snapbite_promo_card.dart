import 'package:flutter/material.dart';

import '../../../core/promo/snapbite_store_launcher.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/glass_surface.dart';
import '../../../l10n/app_localizations.dart';

/// Passive SnapBite cross-promo on the settings screen.
class SnapBitePromoCard extends StatelessWidget {
  const SnapBitePromoCard({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final colors = context.waterColors;

    return GlassSurface(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: () => openSnapBiteStoreListing(),
          child: Row(
            children: [
              DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [colors.mid, colors.deep],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(10),
                  child: Icon(
                    Icons.camera_alt_outlined,
                    color: Colors.white,
                    size: 22,
                  ),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.snapbitePromoTitle,
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: colors.deep,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      l10n.snapbitePromoSubtitle,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: colors.deep.withValues(alpha: 0.72),
                        height: 1.35,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.open_in_new_rounded,
                size: 20,
                color: colors.mid.withValues(alpha: 0.85),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
