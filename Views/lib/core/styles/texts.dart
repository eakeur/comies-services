import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'colors.dart';

TextStyle getPageTitle({double size = 28, FontWeight weight = FontWeight.w600, Color color = White}) {
  return GoogleFonts.barlow(fontSize: size, fontWeight: weight, color: color);
}

TextStyle getButtonText({double size = 16, FontWeight weight = FontWeight.w600, Color? color = White}) {
  return GoogleFonts.barlow(fontSize: size, fontWeight: weight, color: color);
}

TextStyle getSubtitleText({double size = 18, FontWeight weight = FontWeight.w500, Color? color = White}) {
  return GoogleFonts.barlow(fontSize: size, fontWeight: weight, color: color);
}

TextStyle getMainText({double size = 16, FontWeight weight = FontWeight.w400, Color? color = White}) {
  return GoogleFonts.barlow(fontSize: size, fontWeight: weight, color: color);
}

TextStyle getInputLabelText({double size = 18, FontWeight weight = FontWeight.w400, Color? color = White}) {
  return GoogleFonts.barlow(fontSize: size, fontWeight: weight, color: color);
}

TextStyle getHintText({double size = 11, FontWeight weight = FontWeight.w300, Color? color = White}) {
  return GoogleFonts.barlow(fontSize: size, fontWeight: weight, color: color);
}
