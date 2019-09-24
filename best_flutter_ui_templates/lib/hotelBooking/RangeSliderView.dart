import 'package:best_flutter_ui_templates/hotelBooking/hotelAppTheme.dart';
import 'package:flutter/material.dart';

class RangeSliderView extends StatefulWidget {
  final Function(RangeValues) onChnageRangeValues;
  final RangeValues values;

  const RangeSliderView({Key key, this.values, this.onChnageRangeValues}) : super(key: key);
  @override
  _RangeSliderViewState createState() => _RangeSliderViewState();
}

class _RangeSliderViewState extends State<RangeSliderView> {
  RangeValues _values;

  @override
  void initState() {
    _values = widget.values;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Stack(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                    flex: _values.start.round(),
                    child: SizedBox(),
                  ),
                  Container(
                    width: 54,
                    child: Text(
                      "\$${_values.start.round()}",
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Expanded(
                    flex: 1000 - _values.start.round(),
                    child: SizedBox(),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    flex: _values.end.round(),
                    child: SizedBox(),
                  ),
                  Container(
                    width: 54,
                    child: Text(
                      "\$${_values.end.round()}",
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Expanded(
                    flex: 1000 - _values.end.round(),
                    child: SizedBox(),
                  ),
                ],
              ),
            ],
          ),
          SliderTheme(
            data: SliderThemeData(
              rangeThumbShape: CustomRangeThumbShape(),
            ),
            child: RangeSlider(
              values: _values,
              min: 0.0,
              max: 1000.0,
              activeColor: HotelAppTheme.buildLightTheme().primaryColor,
              inactiveColor: Colors.grey.withOpacity(0.4),
              divisions: 1000,
              onChanged: (RangeValues values) {
                try {
                  setState(() {
                    _values = values;
                  });
                  widget.onChnageRangeValues(_values);
                } catch (e) {}
              },
            ),
          ),
        ],
      ),
    );
  }
}
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
