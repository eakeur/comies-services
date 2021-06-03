import 'package:comies/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ComiesTheme {

  late ThemeData _theme;

  ThemeData get theme => _theme;

  ComiesTheme(BuildContext context){
    _theme = ThemeData(

      scaffoldBackgroundColor: ScreenBG,

      backgroundColor: ComponentBG,

      brightness: Brightness.dark,

      primarySwatch: Colors.orange,

      primaryColorDark: PrimaryColorDark,

      primaryColor: PrimaryColor,

      primaryColorBrightness: Brightness.dark,

      primaryColorLight: PrimaryColor,
      
      fontFamily: "Barlow",

      accentColor: PrimaryColor,

      accentColorBrightness: Brightness.dark,

      inputDecorationTheme: InputDecorationTheme(
        fillColor: ScreenBG,
        filled: true,
        contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 14),
        floatingLabelBehavior: FloatingLabelBehavior.never,
        errorStyle: getHintText(color: ErrorColor),
        labelStyle: getInputLabelText(color: Grey),
        hintStyle: getInputLabelText(color: Grey),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(width: 1, color: PrimaryColor)
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(width: 1, color: Grey)
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(width: 1, color: Grey)
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(width: 1, color: ErrorDarkColor)
          )
      ),

      scrollbarTheme: ScrollbarThemeData(isAlwaysShown: true),

      appBarTheme: AppBarTheme(color: Colors.transparent, elevation: 0),

      cardTheme: CardTheme(
        color: ComponentBG, elevation: 0, 
        shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20)),
      )

    );
  }
}
