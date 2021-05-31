import 'package:comies/core.dart';
import 'package:comies/utils/declarations/storage.dart';
import 'package:comies/views/main/main-screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'controllers/main.controller.dart';

SessionController session;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized(); await initDB();
  runApp(ChangeNotifierProvider(create: (context) => new ComiesProvider(), child: MainScreen()));
}
