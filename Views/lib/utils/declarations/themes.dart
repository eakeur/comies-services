import 'package:comies/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

ThemeData mainTheme(Brightness brightness) {
  return ThemeData(
    scaffoldBackgroundColor: screenBG,
    backgroundColor: brightness == Brightness.dark ? Color(0xFF1F1D2B) : Color(0xFFF1EBD9),
    brightness: brightness,
    primarySwatch: Colors.deepOrange,
    primaryColor: Colors.deepOrange,
    fontFamily: "Poppins",
    appBarTheme: AppBarTheme(color: Colors.deepOrange, centerTitle: true, elevation: 20, systemOverlayStyle: SystemUiOverlayStyle.dark),
    bottomAppBarTheme: BottomAppBarTheme(elevation: 8, shape: CircularNotchedRectangle()),
    accentColor: Colors.yellow[800],

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        elevation: MaterialStateProperty.all(1.5),
        minimumSize: MaterialStateProperty.all(Size(90, 45)),
        visualDensity: VisualDensity.comfortable,
        shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(100.0)))
      )
    ),

    outlinedButtonTheme: OutlinedButtonThemeData(
      style: ButtonStyle(
        minimumSize: MaterialStateProperty.all(Size(90, 45)),
        visualDensity: VisualDensity.comfortable,
        shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(100.0), side: BorderSide(color: Colors.deepOrange)))
      )
    ),

    snackBarTheme: SnackBarThemeData(
      elevation: 7,
      shape: RoundedRectangleBorder()
    ),

    accentColorBrightness: Brightness.light,
    floatingActionButtonTheme: FloatingActionButtonThemeData(
        hoverColor: Colors.deepOrange, focusColor: Colors.deepOrange),
    primaryColorDark: Colors.deepOrange[800],


    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      contentPadding: EdgeInsets.only(
        left: 15,
        bottom: 5,
      ),
      focusColor: Colors.yellow[800],
    ),



    toggleButtonsTheme:
        ToggleButtonsThemeData(selectedColor: Colors.yellow[800]),
  );
}



ButtonStyle successButton = ButtonStyle(
  backgroundColor: MaterialStateProperty.all(Colors.green[600])
);

ButtonStyle dangerButton = ButtonStyle(
  backgroundColor: MaterialStateProperty.all(Colors.red[600])
);
