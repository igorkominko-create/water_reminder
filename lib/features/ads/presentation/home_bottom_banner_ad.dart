import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/di/providers.dart';
import '../../../core/theme/app_theme.dart';

/// Adaptive-width banner pinned to the bottom of the home screen.
class HomeBottomBannerAd extends ConsumerStatefulWidget {
  const HomeBottomBannerAd({super.key});

  @override
  ConsumerState<HomeBottomBannerAd> createState() => _HomeBottomBannerAdState();
}

class _HomeBottomBannerAdState extends ConsumerState<HomeBottomBannerAd> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ads = ref.watch(admobServiceProvider);
    final banner = ads.bannerAdWidget;

    if (banner == null) {
      return const SizedBox.shrink();
    }

    final colors = context.waterColors;

    return ColoredBox(
      color: colors.surface,
      child: SafeArea(
        top: false,
        child: SizedBox(
          width: double.infinity,
          height: ads.bannerHeight,
          child: Center(child: banner),
        ),
      ),
    );
  }
}

