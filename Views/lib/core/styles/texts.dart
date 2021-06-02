import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

TextStyle getPageTitle({double size = 28, FontWeight weight = FontWeight.w600, Color color = const Color(0xFFFAFAFA)}) {
  return GoogleFonts.barlow(fontSize: size, fontWeight: weight, color: color);
}

TextStyle getButtonText({double size = 16, FontWeight weight = FontWeight.w600, Color? color = const Color(0xFFFAFAFA)}) {
  return GoogleFonts.barlow(fontSize: size, fontWeight: weight, color: color);
}