import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../l10n/app_localizations.dart';

class WaterProgressRing extends StatelessWidget {
  const WaterProgressRing({
    super.key,
    required this.progress,
    required this.todayMl,
    required this.goalMl,
    required this.percent,
  });

  final double progress;
  final int todayMl;
  final int goalMl;
  final int percent;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final colors = context.waterColors;

    return TweenAnimationBuilder<double>(
      tween: Tween(end: progress.clamp(0.0, 1.0)),
      duration: const Duration(milliseconds: 650),
      curve: Curves.easeOutCubic,
      builder: (context, animatedProgress, _) {
        return SizedBox(
          width: 260,
          height: 260,
          child: Stack(
            alignment: Alignment.center,
            children: [
              CustomPaint(
                size: const Size(260, 260),
                painter: _RingPainter(
                  progress: animatedProgress,
                  trackColor: colors.foam,
                  fillStart: colors.light,
                  fillEnd: colors.mid,
                ),
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '$percent%',
                    style: Theme.of(context).textTheme.displayMedium?.copyWith(
                          fontWeight: FontWeight.w700,
                          color: colors.deep,
                          letterSpacing: -1.5,
                        ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    l10n.mlWithUnit(todayMl),
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: colors.mid,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  Text(
                    l10n.ofDailyGoal(goalMl),
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: colors.deep.withValues(alpha: 0.55),
                        ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

class _RingPainter extends CustomPainter {
  _RingPainter({
    required this.progress,
    required this.trackColor,
    required this.fillStart,
    required this.fillEnd,
  });

  final double progress;
  final Color trackColor;
  final Color fillStart;
  final Color fillEnd;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 14;
    const stroke = 16.0;
    final isFull = progress >= 0.9999;

    final fill = Paint()
      ..shader = SweepGradient(
        colors: [fillStart, fillEnd],
        startAngle: -math.pi / 2,
        endAngle: 3 * math.pi / 2,
      ).createShader(Rect.fromCircle(center: center, radius: radius))
      ..style = PaintingStyle.stroke
      ..strokeWidth = stroke
      ..strokeCap = isFull ? StrokeCap.butt : StrokeCap.round;

    if (!isFull) {
      final track = Paint()
        ..color = trackColor
        ..style = PaintingStyle.stroke
        ..strokeWidth = stroke
        ..strokeCap = StrokeCap.round;
      canvas.drawCircle(center, radius, track);
    }

    final sweep = 2 * math.pi * progress;
    if (sweep > 0) {
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        -math.pi / 2,
        sweep,
        false,
        fill,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _RingPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}
