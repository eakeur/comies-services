import 'package:comies/core.dart';
import 'package:http/http.dart';

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

String getUnitName(Unity unity, [bool abbreviate = true, bool plural = false]) {
  try {
    switch (unity) {
      case Unity.KILOGRAM:
        return (abbreviate ? "kg" : "quilograma" + (plural ? "s" : ""));
      case Unity.MILIGRAM:
        return (abbreviate ? "mg" : "miligrama" + (plural ? "s" : ""));
      case Unity.LITRE:
        return (abbreviate ? "L" : "litro" + (plural ? "s" : ""));
      case Unity.MILILITRE:
        return (abbreviate ? "ml" : "mililitro" + (plural ? "s" : ""));
      case Unity.UNITY:
        return (abbreviate ? "un" : "unidade" + (plural ? "s" : ""));
      case Unity.GRAMM:
        return (abbreviate ? "g" : "grama" + (plural ? "s" : ""));
    }
  } catch (e) {
    print('its here');
    return '';
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

void launchFuture(Future future, BuildContext context, [bool pop = false, VoidCallback? then]) {
  future.then((value) {
    showSuccessFeedback(context, pop);
    if (then != null) {
      then();
    }
  }).catchError((e) {
    showErrorFeedback(e, context);
  });
}

void showErrorFeedback(dynamic result, BuildContext context) {
  var provider = getProvider(context);
  if (result is Response) {
    if (result.statusCode == 400) provider.notify(context, message: result.body, isError: true);
    if (result.statusCode == 401) provider.notify(context, message: 'Parece que você não está conectado. Vamos resolver isso?', isError: true, action: () => Navigator.of(context).pushNamed('/auth'));
    if (result.statusCode == 403) provider.notify(context, title: 'Ih! Fecharam a cozinha', message: 'Você não tem permissão para executar essa ação', isError: true);
    if (result.statusCode == 404) provider.notify(context, title: 'Ué! Cadê?', message: 'Não encontramos o que você procura. Digitou tudo certinho?', isError: true);
    if (result.statusCode >= 500) provider.notify(context, message: 'Não se preocupe, foi falha nossa. Que tal reportar para o responsável pelo app, esse doido?', isError: true);
  } else
    provider.notify(context, message: 'Não se preocupe, foi falha nossa. Que tal reportar para o responsável pelo app, esse doido?', isError: true);
}

void showSuccessFeedback(BuildContext context, [bool pop = false]) {
  var provider = getProvider(context);
  if (pop) Navigator.of(context).pop();
  provider.notify(context, message: 'Sua operação foi realizada com sucesso e tempero!');
}

Future<T?> openSheet<T>({required BuildContext context, required Widget Function(BuildContext) builder}) {
  return showModalBottomSheet(context: context, backgroundColor: Colors.transparent, isScrollControlled: true, elevation: 24, builder: builder);
}
