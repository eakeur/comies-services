import 'dart:io';

import 'package:flutter/material.dart' show runApp;
import 'package:provider/provider.dart' show ChangeNotifierProvider;
import 'package:comies/core.dart' show ComiesController;
import 'package:comies/screens.dart' show MainScreen;

Future<void> main() async {
  HttpOverrides.global = ComiesHttpOverrides();
  runApp(ChangeNotifierProvider(create: (context) => ComiesController(), child: MainScreen()));
}

class ComiesHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    HttpClient client = super.createHttpClient(context);
    client.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
    return client;
  }
}
