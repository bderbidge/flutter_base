import 'package:flutter/material.dart';

final ColorScheme _lightColorScheme = ColorScheme(
  brightness: Brightness.light,
  primary: CompanyColors.green,
  primaryVariant: CompanyColors.darkGreen,
  secondary: CompanyColors.berry,
  secondaryVariant: CompanyColors.darkBerry,
  surface: CompanyColors.white,
  background: CompanyColors.pastelGrey,
  error: CompanyColors.errorRed,
  onError: Colors.white,
  onPrimary: Colors.white,
  onSecondary: Colors.white,
  onBackground: CompanyColors.darkGrey,
  onSurface: Colors.black,
);

// TODO make a dark color scheme
final ColorScheme _darkColorScheme = ColorScheme(
  brightness: Brightness.light,
  primary: CompanyColors.green,
  primaryVariant: CompanyColors.darkGreen,
  secondary: CompanyColors.berry,
  secondaryVariant: CompanyColors.darkBerry,
  surface: CompanyColors.white,
  background: CompanyColors.pastelGrey,
  error: CompanyColors.errorRed,
  onError: Colors.white,
  onPrimary: Colors.white,
  onSecondary: Colors.white,
  onBackground: CompanyColors.darkGrey,
  onSurface: Colors.black,
);

final TextTheme _mainTextTheme = TextTheme();

final ButtonThemeData _mainButtonTheme = ButtonThemeData(
  minWidth: 150.0,
  height: 50.0,
  padding: const EdgeInsets.symmetric(
    vertical: 4.0,
    horizontal: 8.0,
  ),
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(50.0 / 8),
    ),
  ),
);

final ThemeData mainLightTheme = ThemeData.localize(
    ThemeData.light().copyWith(
      colorScheme: _lightColorScheme,
      brightness: Brightness.light,
      backgroundColor: CompanyColors.white,
      scaffoldBackgroundColor: CompanyColors.white,
      dividerColor: Colors.black26,
      splashColor: Colors.black12,
      highlightColor: Colors.black12,
      hoverColor: Colors.black12,
      disabledColor: Colors.black12,
      selectedRowColor: Colors.black12,
      buttonTheme: _mainButtonTheme,
      textSelectionColor: CompanyColors.selectBlue,
    ),
    _mainTextTheme);

final ThemeData mainDarkTheme = ThemeData.localize(
  ThemeData.dark().copyWith(
      brightness: Brightness.dark, backgroundColor: CompanyColors.darkGrey),
  _mainTextTheme,
);

TextTheme _buildTextTheme(TextTheme base) {
  return base
      .copyWith(
        headline1: base.headline1.copyWith(
          fontFamily: 'Eczar',
          fontWeight: FontWeight.w600,
        ),
        headline2: base.headline2.copyWith(
          fontFamily: 'Libre Franklin',
          fontWeight: FontWeight.w300,
        ),
        headline3: base.headline3.copyWith(
          fontFamily: 'Libre Franklin',
          fontWeight: FontWeight.w500,
        ),
        headline4: base.headline4.copyWith(
          fontFamily: 'Eczar',
          fontWeight: FontWeight.w600,
        ),
        headline5: base.headline5.copyWith(
          fontFamily: 'Eczar',
          fontWeight: FontWeight.w600,
        ),
        subtitle2: base.subtitle2.copyWith(
          fontFamily: 'Libre Franklin',
          fontWeight: FontWeight.w500,
        ),
        bodyText2: base.bodyText2.copyWith(
          fontFamily: 'Libre Franklin',
          fontWeight: FontWeight.w400,
          fontSize: 14.0,
        ),
        bodyText1: base.bodyText1.copyWith(
          fontFamily: 'Eczar',
          fontWeight: FontWeight.w400,
          fontSize: 16.0,
        ),
        button: base.button.copyWith(
          fontFamily: 'Libre Franklin',
          fontWeight: FontWeight.w700,
        ),
        caption: base.caption.copyWith(
          fontFamily: 'Eczar',
          fontWeight: FontWeight.w400,
          fontSize: 12.0,
        ),
        overline: base.overline.copyWith(
          fontFamily: 'Libre Franklin',
          fontWeight: FontWeight.w700,
          fontSize: 10.0,
        ),
      )
      .apply(
        displayColor: Colors.black87,
        bodyColor: Colors.black87,
      );
}

/*
 * In front of every Color hex code we need to also indicate
 * the desired opacity.  100% opacity is represented by 0xFF.
 * So just prepend 0xYY (where Y is whatever hex value you want) to your regular
 * hex code.
 * i.e.
 * This color would be written like this:
 * #42B098    =>    0xFF42B098  (100% opacity)
 * #42B098    =>    0x8042B098    (50% opacity)
 * #42B098    =>    0x42B098    (0% opacity or 'invisible') notice there is no need to put 0x00 in)
 *
 * Here's a list of all the opacity hex values in increments of 5.
 * 100% — FF        50% — 80
 * 95% — F2         45% — 73
 * 90% — E6         40% — 66
 * 85% — D9         35% — 59
 * 80% — CC         30% — 4D
 * 75% — BF         25% — 40
 * 70% — B3         20% — 33
 * 65% — A6         15% — 26
 * 60% — 99         10% — 1A
 * 55% — 8C         5% — 0D
 * 40% — 66         0% — 00
 */
class CompanyColors {
  CompanyColors._(); // this basically makes it so you can't instantiate this class

  // Whites, blacks and greys
  static const Color black = Color(0xFF191A1D);
  static const Color darkGrey = Color(0xFF484848);
  static const Color darkGrey50 = Color(0x80484848);
  static const Color darkGrey25 = Color(0x40484848);
  static const Color white = Color(0xFFF5F5F5);
  static const Color pastelGrey = Color(0xFFCDD4CA);
  static const Color silverGrey = Color(0xFF767676);

  // Primary colors
  static const Color green = Color(0xFF007B6D);
  static const Color green50 = Color(0x80007B6D);
  static const Color green25 = Color(0x40007B6D);
  static const Color lightGreen = Color(0xFF00988A);
  static const Color lightGreen50 = Color(0x8000988A);
  static const Color lightGreen25 = Color(0x4000988A);
  static const Color darkGreen = Color(0xFF004130);
  static const Color darkGreen50 = Color(0x80004130);
  static const Color darkGreen25 = Color(0x40004130);

  // Secondary colors
  static const Color berry = Color(0xFF92174D);
  static const Color berry50 = Color(0x8092174D);
  static const Color berry25 = Color(0x4092174D);
  static const Color lightBerry = Color(0xFFA83D71);
  static const Color lightBerry50 = Color(0x80A83D71);
  static const Color lightBerry25 = Color(0x40A83D71);
  static const Color darkBerry = Color(0xFF6F0E2F);
  static const Color darkBerry50 = Color(0x806F0E2F);
  static const Color darkBerry25 = Color(0x406F0E2F);

  // Other colors
  static const Color selectBlue = Color(0xFF007AFF);
  static const Color notificationRed = Color(0xFFFF385C);
  static const Color errorRed = Color(0xFFCB2740);
  static const Color acceptGreen = Color(0xFF4CD964);
}

class CompanyTypography {
  static const TextStyle primaryButtonTextStyle = TextStyle(
    color: CompanyColors.white,
    fontFamily: 'Poppins',
    fontWeight: FontWeight.w600,
    fontSize: 18.0,
  );

  static const TextStyle textBelowIconBlack = TextStyle(
      color: CompanyColors.black,
      fontFamily: 'Poppins',
      fontWeight: FontWeight.normal,
      fontSize: 10.0);

  static const TextStyle textBelowIconWhite = TextStyle(
      color: CompanyColors.white,
      fontFamily: 'Poppins',
      fontWeight: FontWeight.normal,
      fontSize: 10.0);

  static const TextStyle tenantNameCard = TextStyle(
      color: CompanyColors.black,
      fontFamily: 'Poppins',
      fontWeight: FontWeight.w600,
      fontSize: 20.0);

  static const TextStyle tasksRequestsCard = TextStyle(
    color: CompanyColors.black,
    fontFamily: 'Poppins',
    fontWeight: FontWeight.w500,
    fontSize: 16.0,
  );
}
