import 'package:comies/core.dart';
import 'package:flutter/material.dart';

class AuthenticationController {
  late AuthenticationParameters authenticationParameters;
  late BuildContext context;
  late Service service;
  final ValueNotifier<LoadStatus> loadStatus = ValueNotifier(LoadStatus.START);

  AuthenticationController(this.context) {
    service = getProvider(context).service;
  }

  Future<void> authenticate({required String nickname, required String password, bool remember = false}) async {
    loadStatus.value = LoadStatus.LOADING;
    authenticationParameters = AuthenticationParameters(nickname: nickname, password: password);
    try {
      var r = await service.addOne<AuthenticationParameters>(authenticationParameters, route: '/auth', returnType: ReturnType.MAP);
      if (r.success) {
        service.token = r.data['accessToken'];
        getProvider(context).token = r.data['accessToken'];
        Navigator.pushReplacementNamed(context, '/home');
        if (remember) getProvider(context).session.setString('TOKEN', r.data['accessToken']);
      }
      loadStatus.value = r.success ? LoadStatus.LOADED : LoadStatus.FAILED;
    } catch (e) {
      loadStatus.value = LoadStatus.FAILED;
    }
  }
}
