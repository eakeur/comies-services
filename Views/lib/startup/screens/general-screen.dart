import 'package:comies/core.dart' as Core;
import 'package:comies/routes.dart';
import 'package:comies/startup/widgets/widgets.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  Route onGeneratedRoute(RouteSettings settings) {
    var route = routes.firstWhere((route) => route.path == settings.name, orElse: () => new Core.Route(path: '/notfound', name: 'Não encontrado', screen: Container(child: Text('404')), icon: Icons.home));
    return MaterialPageRoute(
        settings: RouteSettings(name: route.path),
        builder: (context) {
          return route.encapsulate ? Scaffold(body: Row(children: [Hero(child: MenuWidget(), tag: 'Menu'), Expanded(child: route.screen)])) : route.screen;
        });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Comies',
      theme: Core.ComiesTheme(context).theme,
      onGenerateRoute: onGeneratedRoute,
      themeMode: ThemeMode.dark,
    );
  }
}
