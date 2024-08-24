import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/progress_provider.dart';

class CustomProgressIndicator extends ConsumerWidget {
  final Color fillColor;
  final Color unfilledColor;
  final VoidCallback onComplete;

  const CustomProgressIndicator({
    Key? key,
    required this.fillColor,
    required this.unfilledColor,
    required this.onComplete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final progress = ref.watch(progressProvider);

    if (progress == 1.0) {
      Future.microtask(onComplete);
    }

    return Stack(
      alignment: Alignment.center,
      children: [
        CustomPaint(
          size: const Size(100, 100),
          painter: _CircularProgressPainter(
            progress: progress,
            fillColor: fillColor,
            unfilledColor: unfilledColor,
          ),
        ),
        Text(
          '${(progress * 100).toInt()}%',
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}

class _CircularProgressPainter extends CustomPainter {
  final double progress;
  final Color fillColor;
  final Color unfilledColor;

  _CircularProgressPainter({
    required this.progress,
    required this.fillColor,
    required this.unfilledColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    // Draw unfilled portion with dashed line (static)
    final unfilledPaint = Paint()
      ..color = unfilledColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8;

    final unfilledPath = Path()
      ..addArc(rect, 0, 2 * 3.1415927);

    final dashArray = [5.0, 3.0]; // Dash pattern
    Path dashPath = _createDashedPath(unfilledPath, dashArray);
    canvas.drawPath(dashPath, unfilledPaint);

    // Draw filled portion (dynamic progress)
    final filledPaint = Paint()
      ..color = fillColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8;

    final filledPath = Path()
      ..addArc(rect, -3.1415927 / 2, progress * 2 * 3.1415927);
    canvas.drawPath(filledPath, filledPaint);
  }

  Path _createDashedPath(Path source, List<double> dashArray) {
    Path dest = Path();
    for (PathMetric measurePath in source.computeMetrics()) {
      double distance = 0.0;
      int index = 0;
      bool draw = true;
      while (distance < measurePath.length) {
        final len = dashArray[index % dashArray.length];
        if (draw) {
          dest.addPath(
            measurePath.extractPath(distance, distance + len),
            Offset.zero,
          );
        }
        distance += len;
        draw = !draw;
        index++;
      }
    }
    return dest;
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
