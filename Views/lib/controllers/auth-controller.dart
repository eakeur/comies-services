import 'package:comies/core.dart';
import 'package:datacontext/datacontext.dart';
import 'package:flutter/material.dart';

class AuthenticationController {
  late AuthenticationParameters authenticationParameters;
  late BuildContext context;
  late Service service;
  final ValueNotifier<LoadStatus> loadStatus = ValueNotifier(LoadStatus.LOADED);

  AuthenticationController(this.context) {
    service = getProvider(context).service;
  }

  Future<void> authenticate({required String nickname, required String password, bool remember = false}) async {
    loadStatus.value = LoadStatus.LOADING;
    authenticationParameters = AuthenticationParameters(nickname: nickname, password: password);
    try {
      var r = await service.addOne<AuthenticationParameters>(authenticationParameters, route: '/auth');
      if (r.success) {
        if (r.token != null){
          service.token = r.token!;
          getProvider(context).token = r.token!;
          Navigator.pushReplacementNamed(context, '/home');
          if (remember) getProvider(context).session.setString('TOKEN', r.token!);
        }
      }
      loadStatus.value = r.success ? LoadStatus.LOADED : LoadStatus.FAILED;
    } catch (e) {
      loadStatus.value = LoadStatus.FAILED;
    }
  }
}
