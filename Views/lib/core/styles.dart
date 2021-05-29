import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

TextStyle getStyle({TextStyle textStyle, Color color, Color backgroundColor, double fontSize, FontWeight fontWeight, FontStyle fontStyle, double letterSpacing, double wordSpacing, TextBaseline textBaseline, double height, Locale locale, Paint foreground, Paint background, List<Shadow> shadows, List<FontFeature> fontFeatures, TextDecoration decoration, Color decorationColor, TextDecorationStyle decorationStyle, double decorationThickness}) {
  return GoogleFonts.varelaRound();
}

final TextStyle title = GoogleFonts.varelaRound(
  fontSize: 20,
  fontWeight: FontWeight.w400,
);

final TextStyle titleBold = GoogleFonts.varelaRound(
  fontSize: 20,
  fontWeight: FontWeight.w600,
);

final TextStyle heading = GoogleFonts.varelaRound(
  fontSize: 18,
  fontWeight: FontWeight.w600,
);

final TextStyle heading40 = GoogleFonts.varelaRound(
  fontSize: 40,
  fontWeight: FontWeight.w600,
);

final TextStyle heading15 = GoogleFonts.varelaRound(
  fontSize: 15,
  fontWeight: FontWeight.w600,
);

final TextStyle body = GoogleFonts.varelaRound(
  fontSize: 13,
  fontWeight: FontWeight.normal,
);

final TextStyle bodyBold = GoogleFonts.varelaRound(
  color: grey,
  fontSize: 13,
  fontWeight: FontWeight.bold,
);

final TextStyle bodylightGrey = GoogleFonts.varelaRound(
  color: successLightColor,
  fontSize: 13,
  fontWeight: FontWeight.normal,
);
final TextStyle bodyDarkGreen = GoogleFonts.varelaRound(
  color: successDarkColor,
  fontSize: 13,
  fontWeight: FontWeight.w500,
);

final TextStyle bodyDarkRed = GoogleFonts.varelaRound(
  color: errorDarkColor,
  fontSize: 13,
  fontWeight: FontWeight.w500,
);

final TextStyle body20 = GoogleFonts.varelaRound(
  color: grey,
  fontSize: 20,
  fontWeight: FontWeight.normal,
);
final TextStyle bodyLightGrey20 = GoogleFonts.varelaRound(
  color: lightGrey,
  fontSize: 20,
  fontWeight: FontWeight.normal,
);

final TextStyle bodyWhite20 = GoogleFonts.varelaRound(
  color: white,
  fontSize: 20,
  fontWeight: FontWeight.normal,
);
final TextStyle body11 = GoogleFonts.varelaRound(
  color: grey,
  fontSize: 11,
  fontWeight: FontWeight.normal,
);
final TextStyle legend = GoogleFonts.varelaRound(
  fontSize: 11,
  fontWeight: FontWeight.normal,
);

final Color white = Color(0xFFFFFFFF);
final Color black = Color(0xFF514766);
final Color grey = Color(0xFF6E6680);
final Color lightGrey = Color(0xFFA6A1B2);

final Color primaryColor = Color(0xFF3A906C);
final Color neutralColor = Color(0xFFF1EBD9);
final Color accentColor = Color(0xFFFA7B52);

final Color successLightColor = Color(0xFFE1F5EC);
final Color successColor = Color(0xFFB8DBCB);
final Color successDarkColor = Color(0xFF04D361);

final Color errorLightColor = Color(0xFFF5E9EC);
final Color errorColor = Color(0xFFE5C5CF);
final Color errorDarkColor = Color(0xFFCC3750);
