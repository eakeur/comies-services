import 'package:comies/core.dart';
import 'package:comies/views/authentication/authentication.screen.dart';
import 'package:comies/views/home/home.screen.dart';
import 'package:comies/views/main/main-screen.dart';
import 'package:flutter/material.dart';
import 'package:comies/core/constants.dart' as Constants;

class ComiesProvider extends ChangeNotifier {
  final Map<String, dynamic> session = new Map<String, dynamic>();

  ThemeMode themeMode = ThemeMode.system;

  Future<void> loadNewSession(BuildContext context) async {
    try {
      String initialPage = '';

      session['ANIM_DURATION'] = (await getSetting('ANIM_DURATION')) ?? Constants.defaultAnimationDuration;
      session['URL'] = (await getSetting('URL')) ?? Constants.defaultAPIUrl;
      session['THEME'] = (await getSetting('THEME')) ?? Constants.defaultThemeMode;
      session['CONN_TYPE'] = (await getSetting('CONN_TYPE')) ?? Constants.connectionType;
      session['TOKEN'] = (await getSetting('TOKEN'));
      session['SETUP'] = (await getSetting('SETUP')) ?? false;
      session['APIKEY'] = Constants.apiKey;

      if (session['SETUP'] as bool) {
        if (session['TOKEN'] != null && session['token'] is String) {
        } else {
          initialPage = '/auth';
        }
      }

      Navigator.pushReplacementNamed(context, initialPage);
    } catch (e) {
      print(e);
    }
  }
}
