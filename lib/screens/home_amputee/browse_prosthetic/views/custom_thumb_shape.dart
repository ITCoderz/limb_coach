import 'package:flutter/material.dart';

class CustomRangeThumbShape extends RangeSliderThumbShape {
  final double thumbRadius;

  CustomRangeThumbShape({this.thumbRadius = 12});

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return Size.fromRadius(thumbRadius);
  }

  @override
  void paint(
    PaintingContext context,
    Offset center, {
    required Animation<double> activationAnimation,
    required Animation<double> enableAnimation,
    bool isDiscrete = false,
    bool isEnabled = false,
    bool isOnTop = false,
    bool isPressed = false,
    required SliderThemeData sliderTheme,
    TextDirection? textDirection,
    Thumb? thumb,
  }) {
    final Canvas canvas = context.canvas;

    final Paint paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    // Thumb circle
    canvas.drawCircle(center, thumbRadius, paint);

    // Border
    final Paint border = Paint()
      ..color = sliderTheme.activeTrackColor ?? Colors.blue
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5;

    canvas.drawCircle(center, thumbRadius, border);
  }
}
