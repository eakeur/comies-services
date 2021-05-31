import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

TextStyle getBigTitle({double size = 36, FontWeight weight = FontWeight.w300, Color color = const Color(0xFF514766)}) {
  return GoogleFonts.brawler(
    fontSize: size,
    fontWeight: weight,
    color: color,
  );
}

TextStyle getPageTitle({double size = 28, FontWeight weight = FontWeight.w600, Color color = const Color(0xFFFAFAFA)}) {
  return GoogleFonts.barlow(fontSize: size, fontWeight: weight, color: color);
}

TextStyle getMediumTitle({double size = 24, FontWeight weight = FontWeight.w300, Color color = const Color(0xFF514766)}) {
  return GoogleFonts.varelaRound(fontSize: size, fontWeight: weight, color: color);
}

TextStyle getBodyTiny({double size = 13, FontWeight weight = FontWeight.w300, Color color}) {
  return GoogleFonts.notoSans(fontSize: size, fontWeight: weight, color: color);
}

TextStyle getButtonText({double size = 16, FontWeight weight = FontWeight.w600, Color color = const Color(0xFFFAFAFA)}) {
  return GoogleFonts.barlow(fontSize: size, fontWeight: weight, color: color);
}

List<BoxShadow> getNeumorphicShadow(double elevation) {
  return [
    BoxShadow(color: Colors.grey.shade300, spreadRadius: 0.0, blurRadius: elevation, offset: Offset(3.0, 3.0)),
    BoxShadow(color: Colors.grey.shade400, spreadRadius: 0.0, blurRadius: elevation / 2.0, offset: Offset(3.0, 3.0)),
    BoxShadow(color: Colors.white, spreadRadius: 2.0, blurRadius: elevation, offset: Offset(-3.0, -3.0)),
    BoxShadow(color: Colors.white, spreadRadius: 2.0, blurRadius: elevation / 2, offset: Offset(-3.0, -3.0)),
  ];
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

final Color screenBG = Color(0xFF252836);
final Color composBG = Color(0xFF1F1D2B);

final Color white = Color(0xFFFAFAFA);
final Color black = Color(0xFF1F1D2B);
final Color grey = Color(0xFF6E6680);
final Color lightGrey = Color(0xFFA6A1B2);

final Color primaryColor = Color(0xFFEA7C69);
final Color primaryColorDark = Color(0xFFE05A43);
final Color neutralColor = Color(0xFFF1EBD9);
final Color accentColor = Color(0xFFFEDE00);

final Color successLightColor = Color(0xFFE1F5EC);
final Color successColor = Color(0xFFB8DBCB);
final Color successDarkColor = Color(0xFF04D361);

final Color errorLightColor = Color(0xFFF5E9EC);
final Color errorColor = Color(0xFFE5C5CF);
final Color errorDarkColor = Color(0xFFCC3750);
