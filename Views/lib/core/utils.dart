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

double getWidth(BuildContext context) {
  return MediaQuery.of(context).size.width;
}

double getHeight(BuildContext context) {
  return MediaQuery.of(context).size.height;
}

SharedPreferences getSession(BuildContext context) {
  return Provider.of<ComiesController>(context, listen: false).session;
}

ComiesController getProvider(BuildContext context) {
  return Provider.of<ComiesController>(context, listen: false);
}

String getGuidView(String? value) {
  return value ?? guidEmpty;
}

String getTextView(String? value, {bool name = false}) {
  return value ?? (name ? 'Sem nome' : '');
}

String getTextValue(String? value, {bool name = false}) {
  return getTextView(value, name: name);
}

String getCurrencyView(double? value) {
  if (value != null) {
    return value.toStringAsFixed(2);
  } else {
    return (0.00).toStringAsFixed(2);
  }
}

double getDoubleValue(String? value) {
  if (value != null) {
    return double.tryParse(value.replaceAll(',', '.')) ?? 0;
  } else {
    return 0;
  }
}

String getDoubleView(double? value, int decimal) {
  if (value != null) {
    return value.toStringAsFixed(decimal);
  } else {
    return (0.00).toStringAsFixed(decimal);
  }
}

String getNumericView(int? value) {
  if (value != null) {
    return value.toString();
  } else {
    return (0).toString();
  }
}

int getNumericValue(String? value) {
  if (value != null) {
    return int.tryParse(value) ?? 0;
  } else {
    return 0;
  }
}

Axis getRelativeAxis(BuildContext context) => isWidthSmall(context) ? Axis.vertical : Axis.horizontal;

int getRelativeFlex(BuildContext context, {int small = 0, int big = 50}) => isWidthSmall(context) ? small : big;

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
