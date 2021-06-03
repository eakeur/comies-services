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
