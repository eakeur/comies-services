import 'package:comies/core.dart';
import 'package:dart_ipify/dart_ipify.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' show get;

class StartupController {
  final connectionTypeNotifier = ValueNotifier<ConnectionType>(ConnectionType.ONLINE);
  final ipNotifier = ValueNotifier<String>('000.000.000.000');

  Future<void> onConnectionTypeChange(ConnectionType type) async {
    try {
      connectionTypeNotifier.value = type;
      ipNotifier.value = await Ipify.ipv4();
      get(Uri.parse(ipNotifier.value + ":5001/api/v1/auth/test")).then((value) => ipNotifier.value = value.body).onError((err, h) => ipNotifier.value = err.toString());
    } catch (e) {
      get(Uri.parse('https://localhost' + ":5001/api/v1/auth/test")).then((value) {
        print(value);
        ipNotifier.value = value.body;
      }).onError((err, h) {
        print(err);
      });
    }
  }
}
