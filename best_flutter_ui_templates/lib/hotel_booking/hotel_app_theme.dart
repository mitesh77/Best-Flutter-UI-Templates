import 'package:best_flutter_ui_templates/main.dart';
import 'package:flutter/material.dart';

class HotelAppTheme {
  static const Color backgroundColor = Color(0xFFFFFFFF);

  static TextTheme _buildTextTheme(TextTheme base) {
    const String fontName = 'WorkSans';
    return base.copyWith(
      displayLarge: base.displayLarge
          ?.copyWith(fontFamily: fontName), // headline1 -> displayLarge
      displayMedium: base.displayMedium
          ?.copyWith(fontFamily: fontName), // headline2 -> displayMedium
      displaySmall: base.displaySmall
          ?.copyWith(fontFamily: fontName), // headline3 -> displaySmall
      headlineMedium: base.headlineMedium
          ?.copyWith(fontFamily: fontName), // headline4 -> headlineMedium
      headlineSmall: base.headlineSmall
          ?.copyWith(fontFamily: fontName), // headline5 -> headlineSmall
      titleLarge: base.titleLarge
          ?.copyWith(fontFamily: fontName), // headline6 -> titleLarge
      labelLarge: base.labelLarge
          ?.copyWith(fontFamily: fontName), // button -> labelLarge
      bodySmall: base.bodySmall
          ?.copyWith(fontFamily: fontName), // caption -> bodySmall
      bodyLarge: base.bodyLarge
          ?.copyWith(fontFamily: fontName), // bodyText1 -> bodyLarge
      bodyMedium: base.bodyMedium
          ?.copyWith(fontFamily: fontName), // bodyText2 -> bodyMedium
      titleMedium: base.titleMedium
          ?.copyWith(fontFamily: fontName), // subtitle1 -> titleMedium
      titleSmall: base.titleSmall
          ?.copyWith(fontFamily: fontName), // subtitle2 -> titleSmall
      labelSmall: base.labelSmall
          ?.copyWith(fontFamily: fontName), // overline -> labelSmall
    );
  }

  static ThemeData buildLightTheme() {
    final Color primaryColor = HexColor('#54D3C2');
    final Color secondaryColor = HexColor('#54D3C2');
    final ColorScheme colorScheme = const ColorScheme.light().copyWith(
      primary: primaryColor,
      secondary: secondaryColor,
      surface: const Color(0xFFFFFFFF),
      error: const Color(0xFFB00020),
    );
    final ThemeData base = ThemeData.light();
    return base.copyWith(
      colorScheme: colorScheme,
      primaryColor: primaryColor,
      indicatorColor: Colors.white,
      splashColor: Colors.white24,
      splashFactory: InkRipple.splashFactory,
      canvasColor: Colors.white,
      scaffoldBackgroundColor: const Color(0xFFF6F6F6),
      buttonTheme: ButtonThemeData(
        colorScheme: colorScheme,
        textTheme: ButtonTextTheme.primary,
      ),
      textTheme: _buildTextTheme(base.textTheme),
      primaryTextTheme: _buildTextTheme(base.primaryTextTheme),
      platform: TargetPlatform.iOS,
    );
  }
}
