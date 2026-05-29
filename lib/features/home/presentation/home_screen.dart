import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/di/providers.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/glass_surface.dart';
import '../../../core/widgets/gradient_scaffold.dart';
import '../../../l10n/app_localizations.dart';
import '../../promo/presentation/goal_celebration_listener.dart';
import '../../promo/presentation/snapbite_banner_widget.dart';
import '../../settings/presentation/settings_screen.dart';
import 'widgets/hydration_summary_header.dart';
import 'widgets/quick_add_section.dart';
import 'widgets/water_progress_ring.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final async = ref.watch(hydrationNotifierProvider);
    final topPadding = MediaQuery.paddingOf(context).top;

    return GoalCelebrationListener(
      child: GradientScaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Text(l10n.homeTitle),
          actions: [
            IconButton(
              tooltip: l10n.settingsTooltip,
              icon: const Icon(Icons.more_horiz_rounded),
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute<void>(builder: (_) => const SettingsScreen()),
              ),
            ),
          ],
        ),
        bottomNavigationBar: const SnapBiteBannerWidget(),
        body: async.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, _) => Center(child: Text(l10n.errorMessage('$e'))),
          data: (snapshot) {
            return SafeArea(
              top: false,
              child: SingleChildScrollView(
                padding: EdgeInsets.fromLTRB(
                  24,
                  topPadding + kToolbarHeight + 8,
                  24,
                  16,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    HydrationSummaryHeader(snapshot: snapshot),
                    const SizedBox(height: 32),
                    Center(
                      child: WaterProgressRing(
                        progress: snapshot.progress,
                        todayMl: snapshot.todayMl,
                        goalMl: snapshot.goalMl,
                        percent: snapshot.percent,
                      ),
                    ),
                    const SizedBox(height: 36),
                    QuickAddSection(
                      onAdd: (ml) => ref
                          .read(hydrationNotifierProvider.notifier)
                          .addWater(ml),
                    ),
                    const SizedBox(height: 20),
                    _WidgetHint(colors: context.waterColors),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _WidgetHint extends StatelessWidget {
  const _WidgetHint({required this.colors});

  final WaterColors colors;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return GlassSurface(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      child: Row(
        children: [
          DecoratedBox(
            decoration: BoxDecoration(
              color: colors.foam,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Icon(Icons.widgets_rounded, color: colors.mid, size: 22),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Text(
              l10n.widgetHint,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: colors.deep.withValues(alpha: 0.75),
                    height: 1.35,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
