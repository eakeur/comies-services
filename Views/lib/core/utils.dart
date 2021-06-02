import 'providers.dart';
import 'models.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

ScreenSize getScreenWidth(BuildContext context) {
  return MediaQuery.of(context).size.width <= 750
      ? ScreenSize.XSMALL
      : MediaQuery.of(context).size.width <= 1366
          ? ScreenSize.SMALL
          : MediaQuery.of(context).size.width <= 1366
              ? ScreenSize.MEDIUM
              : MediaQuery.of(context).size.width <= 1680
                  ? ScreenSize.LARGE
                  : ScreenSize.XLARGE;
}

SharedPreferences getSession(BuildContext context) {
  return Provider.of<ComiesController>(context, listen: false).session;
}

ComiesController getProvider(BuildContext context) {
  return Provider.of<ComiesController>(context, listen: false);
}
