import 'package:flutter/material.dart';

import '../../../core/promo/snapbite_store_launcher.dart';
import '../../../core/theme/app_theme.dart';
import '../../../l10n/app_localizations.dart';

/// Fixed-height cross-promo strip for SnapBite (replaces third-party ad banners).
class SnapBiteBannerWidget extends StatelessWidget {
  const SnapBiteBannerWidget({super.key});

  /// Standard mobile banner height (~50–60 dp).
  static const double height = 56;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final colors = context.waterColors;

    return Material(
      color: colors.surface,
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: height,
          width: double.infinity,
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: openSnapBiteStoreListing,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      const Color(0xFF2ECC71).withValues(alpha: 0.14),
                      colors.foam,
                    ],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                  border: Border(
                    top: BorderSide(
                      color: const Color(0xFF2ECC71).withValues(alpha: 0.35),
                    ),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      DecoratedBox(
                        decoration: BoxDecoration(
                          color: const Color(0xFF2ECC71).withValues(alpha: 0.18),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(7),
                          child: Icon(
                            Icons.camera_alt_outlined,
                            size: 18,
                            color: Color(0xFF1F8A55),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          l10n.snapbiteBannerMessage,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style:
                              Theme.of(context).textTheme.labelLarge?.copyWith(
                                    color: colors.deep,
                                    fontWeight: FontWeight.w600,
                                    height: 1.2,
                                  ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Icon(
                        Icons.arrow_forward_rounded,
                        size: 18,
                        color: colors.deep.withValues(alpha: 0.65),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
