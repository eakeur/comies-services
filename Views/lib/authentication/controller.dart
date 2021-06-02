import 'package:comies/core.dart';
import 'package:flutter/material.dart';

class AuthenticationController {
  late AuthenticationParameters authenticationParameters;
  late BuildContext context;
  late Service service;

  AuthenticationController(this.context) {
    service = getProvider(context).service;
  }

  Future<void> authenticate({required String nickname, required String password, bool remember = false}) async {
    authenticationParameters = AuthenticationParameters(nickname: nickname, password: password);
    var r = await service.addOne<AuthenticationParameters>(authenticationParameters, route: '/auth', returnType: ReturnType.MAP);
    if (r.success) {
      service.token = r.data['accessToken'];
      getProvider(context).token = r.data['accessToken'];
      Navigator.pushReplacementNamed(context, '/home');
    }
  }
}
