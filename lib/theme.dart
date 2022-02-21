import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'constants.dart';

// Our light/Primary Theme
ThemeData themeData(BuildContext context) {
  return ThemeData(
    appBarTheme: appBarLightTheme,
    primaryColor: kPrimaryColor,
    scaffoldBackgroundColor: Colors.white,
    backgroundColor: Colors.white,
    iconTheme: const IconThemeData(color: kBodyTextColorLight),
    primaryIconTheme: const IconThemeData(color: kPrimaryIconLightColor),
    textTheme: GoogleFonts.latoTextTheme().copyWith(
      bodyText1: const TextStyle(color: kBodyTextColorLight),
      bodyText2: const TextStyle(color: kBodyTextColorLight),
      headline4: const TextStyle(color: kTitleTextLightColor, fontSize: 32),
      headline1: const TextStyle(color: kTitleTextLightColor, fontSize: 80),
    ),
    colorScheme: const ColorScheme.light(
      secondary: kSecondaryLightColor,
      secondaryContainer: kAccentLightColor,
      primary: kPrimaryColor,
      onPrimary: Colors.white,
      // on light theme surface = Colors.white by default
    ),
  );
}

// Dark Them
ThemeData darkThemeData(BuildContext context) {
  return ThemeData.dark().copyWith(
    primaryColor: kPrimaryColor,
    scaffoldBackgroundColor: const Color(0xFF0D0C0E),
    appBarTheme: appBarDarkTheme,
    backgroundColor: kBackgroundDarkColor,
    iconTheme: const IconThemeData(color: kBodyTextColorDark),
    primaryIconTheme: const IconThemeData(color: kPrimaryIconDarkColor),
    textTheme: GoogleFonts.latoTextTheme().copyWith(
      bodyText1: const TextStyle(color: kBodyTextColorDark),
      bodyText2: const TextStyle(color: kBodyTextColorDark),
      headline4: const TextStyle(color: kTitleTextDarkColor, fontSize: 32),
      headline1: const TextStyle(color: kTitleTextDarkColor, fontSize: 80),
    ),
    colorScheme: const ColorScheme.dark(
      secondary: kSecondaryDarkColor,
      secondaryContainer: kAccentDarkColor,
      surface: kSurfaceDarkColor,
      onSurface: Colors.white,
      primary: kPrimaryColor,
      onPrimary: kBackgroundDarkColor,
    ),
  );
}

AppBarTheme appBarLightTheme = AppBarTheme(
  // affect the color of SystemUI
  color: Colors.white.withOpacity(0),
  elevation: 0,
);
AppBarTheme appBarDarkTheme = AppBarTheme(
  // affect the color of SystemUI
  color: Colors.black.withOpacity(0),
  elevation: 0,
);
