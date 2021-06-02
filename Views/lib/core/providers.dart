import 'package:comies/core.dart';
import 'package:flutter/material.dart';
import 'constants.dart' as Constants;
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ComiesController extends ChangeNotifier {
  late SharedPreferences session;
  late Service service;
  late String token;

  Map<String, dynamic> get operatorProperties => JwtDecoder.decode(token);

  Future<void> loadNewSession(BuildContext context) async {
    var route = '/auth';
    try {
      session = await SharedPreferences.getInstance();
      if (session.getKeys().isEmpty)
        createSession(context);
      else {
        if (true /**session.getBool('SETUP') ?? false */ ) {
          var token = session.getString('TOKEN');
          if (token == null)
            route = '/auth';
          else if (JwtDecoder.isExpired(token))
            route = '/auth';
          else {
            this.token = token;
            route = '/home';
          }
        } else
          route = '/auth'; //rotear para tela de confugurações iniciais
      }
    } catch (e) {
      print(e);
    } finally {
      service = Service(context: context);
      Navigator.pushReplacementNamed(context, route);
    }
  }

  Future<void> createSession(BuildContext context) async {
    try {
      session.setInt('ANIM_DURATION', Constants.defaultAnimationDuration);
      session.setString('URL', Constants.defaultAPIUrl);
      session.setInt('CONN_TYPE', Constants.connectionType.index);
      session.setInt('ANIM_DURATION', Constants.defaultAnimationDuration);
      session.setInt('ANIM_DURATION', Constants.defaultAnimationDuration);
      session.setBool('SETUP', false);
      session.setString('APIKEY', Constants.apiKey);
      service = Service(context: context);
    } catch (e) {}
  }

  String? get operatorName => operatorProperties['unique_name'];
}
