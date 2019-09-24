import 'package:flutter/material.dart';
import 'dart:math' as math;

class CustomRangeThumbShape extends RangeSliderThumbShape {
  static const double _thumbSize = 3.0;
  static const double _disabledThumbSize = 3.0;

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return isEnabled ? const Size.fromRadius(_thumbSize) : const Size.fromRadius(_disabledThumbSize);
  }

  static final Animatable<double> sizeTween = Tween<double>(
    begin: _disabledThumbSize,
    end: _thumbSize,
  );

  @override
  void paint(
    PaintingContext context,
    Offset center, {
    @required Animation<double> activationAnimation,
    @required Animation<double> enableAnimation,
    bool isDiscrete = false,
    bool isEnabled = false,
    bool isOnTop,
    @required SliderThemeData sliderTheme,
    TextDirection textDirection,
    Thumb thumb,
  }) {
    final Canvas canvas = context.canvas;
    final ColorTween colorTween = ColorTween(
      begin: sliderTheme.disabledThumbColor,
      end: sliderTheme.thumbColor,
    );

    final double size = _thumbSize * sizeTween.evaluate(enableAnimation);
    Path thumbPath;
    switch (textDirection) {
      case TextDirection.rtl:
        switch (thumb) {
          case Thumb.start:
            thumbPath = _rightTriangle(size, center);
            break;
          case Thumb.end:
            thumbPath = _leftTriangle(size, center);
            break;
        }
        break;
      case TextDirection.ltr:
        switch (thumb) {
          case Thumb.start:
            thumbPath = _leftTriangle(size, center);
            break;
          case Thumb.end:
            thumbPath = _rightTriangle(size, center);
            break;
        }
        break;
    }

    canvas.drawPath(
        Path()
          ..addOval(Rect.fromPoints(Offset(center.dx + 12, center.dy + 12), Offset(center.dx - 12, center.dy - 12)))
          ..fillType = PathFillType.evenOdd,
        Paint()
          ..color = Colors.black.withOpacity(0.5)
          ..maskFilter = MaskFilter.blur(BlurStyle.normal, convertRadiusToSigma(8)));

    var cPaint = new Paint();
    cPaint..color = Colors.white;
    cPaint..strokeWidth = 14 / 2;
    canvas.drawCircle(Offset(center.dx, center.dy), 12, cPaint);
    cPaint..color = colorTween.evaluate(enableAnimation);
    canvas.drawCircle(Offset(center.dx, center.dy), 10, cPaint);
    canvas.drawPath(thumbPath, Paint()..color = Colors.white);
  }

  double convertRadiusToSigma(double radius) {
    return radius * 0.57735 + 0.5;
  }

  Path _rightTriangle(double size, Offset thumbCenter, {bool invert = false}) {
    final Path thumbPath = Path();
    final double sign = invert ? -1.0 : 1.0;
    thumbPath.moveTo(thumbCenter.dx + 5 * sign, thumbCenter.dy);
    thumbPath.lineTo(thumbCenter.dx - 3 * sign, thumbCenter.dy - 5);
    thumbPath.lineTo(thumbCenter.dx - 3 * sign, thumbCenter.dy + 5);
    thumbPath.close();
    return thumbPath;
  }

  Path _leftTriangle(double size, Offset thumbCenter) => _rightTriangle(size, thumbCenter, invert: true);
}

class CustomThumbShape extends SliderComponentShape {
  static const double _thumbSize = 3.0;
  static const double _disabledThumbSize = 3.0;

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return isEnabled ? const Size.fromRadius(_thumbSize) : const Size.fromRadius(_disabledThumbSize);
  }

  static final Animatable<double> sizeTween = Tween<double>(
    begin: _disabledThumbSize,
    end: _thumbSize,
  );

  @override
  void paint(
    PaintingContext context,
    Offset thumbCenter, {
    Animation<double> activationAnimation,
    Animation<double> enableAnimation,
    bool isDiscrete,
    TextPainter labelPainter,
    RenderBox parentBox,
    SliderThemeData sliderTheme,
    TextDirection textDirection,
    double value,
  }) {
    final Canvas canvas = context.canvas;
    final ColorTween colorTween = ColorTween(
      begin: sliderTheme.disabledThumbColor,
      end: sliderTheme.thumbColor,
    );
    canvas.drawPath(
        Path()
          ..addOval(Rect.fromPoints(Offset(thumbCenter.dx + 12, thumbCenter.dy + 12), Offset(thumbCenter.dx - 12, thumbCenter.dy - 12)))
          ..fillType = PathFillType.evenOdd,
        Paint()
          ..color = Colors.black.withOpacity(0.5)
          ..maskFilter = MaskFilter.blur(BlurStyle.normal, convertRadiusToSigma(8)));

    var cPaint = new Paint();
    cPaint..color = Colors.white;
    cPaint..strokeWidth = 14 / 2;
    canvas.drawCircle(Offset(thumbCenter.dx, thumbCenter.dy), 12, cPaint);
    cPaint..color = colorTween.evaluate(enableAnimation);
    canvas.drawCircle(Offset(thumbCenter.dx, thumbCenter.dy), 10, cPaint);
  }

  double convertRadiusToSigma(double radius) {
    return radius * 0.57735 + 0.5;
  }
}

// class DialogBorder extends ShapeBorder {
//   final double radius;
//   const DialogBorder({this.radius = 24});

//   @override
//   EdgeInsetsGeometry get dimensions {
//     return const EdgeInsets.only();
//   }

//   @override
//   Path getInnerPath(Rect rect, {TextDirection textDirection}) {
//     return getOuterPath(rect, textDirection: textDirection);
//   }

//   @override
//   Path getOuterPath(Rect rect, {TextDirection textDirection}) {
//     final doubleRadius = radius * 2;
//     final path = Path();
//     path.lineTo(0, 0);
//     path.arcTo(Rect.fromLTWH(0, 0, doubleRadius, doubleRadius), degreeToRadians(180), degreeToRadians(90), false);
//     path.arcTo(Rect.fromLTWH(rect.width - doubleRadius, 0, doubleRadius, doubleRadius), degreeToRadians(270), degreeToRadians(90), false);
//     path.arcTo(Rect.fromLTWH(rect.width - doubleRadius, rect.height - doubleRadius, doubleRadius, doubleRadius), degreeToRadians(0), degreeToRadians(90), false);
//     path.arcTo(Rect.fromLTWH(0, rect.height - doubleRadius, doubleRadius, doubleRadius), degreeToRadians(90), degreeToRadians(90), false);
//     path.close();
//     return path;
//   }

//   @override
//   void paint(Canvas canvas, Rect rect, {TextDirection textDirection}) {}

//   // This border doesn't support scaling.
//   @override
//   ShapeBorder scale(double t) {
//     return null;
//   }

//   double degreeToRadians(double degree) {
//     var redian = (math.pi / 180) * degree;
//     return redian;
//   }
// }
