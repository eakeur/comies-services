import 'package:comies/core/models/screensize.dart';
import 'package:comies/core/provider.dart';
import 'package:comies/utils/declarations/storage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sembast/sembast.dart';

import 'constants.dart';

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

T getValue<T>(BuildContext context, String key) {
  return Provider.of<ComiesProvider>(context, listen: false).session[key] as T;
}

final StoreRef collection = StoreRef.main();

Future<dynamic> addSetting(String key, dynamic value) async {
    try {
       return await collection.record(key).put(storage, value);
       
    } catch (e) {
      print(e);
    }
  }

Future<dynamic> removeSetting(String key) async {
  try {
    return await collection.record(key).delete(storage);
  } catch (e) {
    print(e);
  }
}

Future<T> getSetting<T>(String key) async {
  try {
    return await collection.record(key).get(storage) as T;
  } catch (e) {
    print(e);
    return null;
  }
}