import 'package:comies/core.dart';

import 'providers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

bool isWidthSmall(BuildContext context) {
  return MediaQuery.of(context).size.width <= 800;
}

bool isHeightSmall(BuildContext context) {
  return MediaQuery.of(context).size.height <= 600;
}

SharedPreferences getSession(BuildContext context) {
  return Provider.of<ComiesController>(context, listen: false).session;
}

ComiesController getProvider(BuildContext context) {
  return Provider.of<ComiesController>(context, listen: false);
}

void showFeedback(BuildContext context, {required String title, String? details, bool success = true, VoidCallback? action}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: success ? Colors.green[700] : Colors.red[700],
      action: action != null ? SnackBarAction(label: success ? "DESFAZER" : "TENTAR DE NOVO", onPressed: action, textColor: Colors.white) : null,
      duration: Duration(seconds: 5),
      content: ListTile(
        title: Text(title, style: TextStyle(color: Colors.white)),
        subtitle: details != null ? Text(details) : null,
      ), 
    ),
  );
}
