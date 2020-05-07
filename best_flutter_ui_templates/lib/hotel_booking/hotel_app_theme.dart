import 'package:best_flutter_ui_templates/main.dart';
import 'package:flutter/material.dart';

class HotelAppTheme {
  static TextTheme _buildTextTheme(TextTheme base) {
    const String fontName = 'WorkSans';
    return base.copyWith(
      headline1: base.headline1.copyWith(fontFamily: fontName),
      headline2: base.headline2.copyWith(fontFamily: fontName),
      headline3: base.headline3.copyWith(fontFamily: fontName),
      headline4: base.headline4.copyWith(fontFamily: fontName),
      headline5: base.headline5.copyWith(fontFamily: fontName),
      headline6: base.headline6.copyWith(fontFamily: fontName),
      button: base.button.copyWith(fontFamily: fontName),
      caption: base.caption.copyWith(fontFamily: fontName),
      bodyText1: base.bodyText1.copyWith(fontFamily: fontName),
      bodyText2: base.bodyText2.copyWith(fontFamily: fontName),
      subtitle1: base.subtitle1.copyWith(fontFamily: fontName),
      subtitle2: base.subtitle2.copyWith(fontFamily: fontName),
      overline: base.overline.copyWith(fontFamily: fontName),
    );
  }

  static ThemeData buildLightTheme() {
    final Color primaryColor = HexColor('#54D3C2');
    final Color secondaryColor = HexColor('#54D3C2');
    final ColorScheme colorScheme = const ColorScheme.light().copyWith(
      primary: primaryColor,
      secondary: secondaryColor,
    );
    final ThemeData base = ThemeData.light();
    return base.copyWith(
      colorScheme: colorScheme,
      primaryColor: primaryColor,
      buttonColor: primaryColor,
      indicatorColor: Colors.white,
      splashColor: Colors.white24,
      splashFactory: InkRipple.splashFactory,
      accentColor: secondaryColor,
      canvasColor: Colors.white,
      backgroundColor: const Color(0xFFFFFFFF),
      scaffoldBackgroundColor: const Color(0xFFF6F6F6),
      errorColor: const Color(0xFFB00020),
      buttonTheme: ButtonThemeData(
        colorScheme: colorScheme,
        textTheme: ButtonTextTheme.primary,
      ),
      textTheme: _buildTextTheme(base.textTheme),
      primaryTextTheme: _buildTextTheme(base.primaryTextTheme),
      accentTextTheme: _buildTextTheme(base.accentTextTheme),
      platform: TargetPlatform.iOS,
    );
  }
}
