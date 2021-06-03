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
        return route.encapsulate ? 
          SafeArea(
            child: Scaffold(
              body: Stack(
                children: [
                  Container(
                    padding: EdgeInsets.only(left: Core.isWidthSmall(context) ? 7 : 80, right: 7), 
                    child: route.screen,
                  ),
                  Core.isWidthSmall(context) 
                  ? Positioned.fill(
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Hero(
                        child: MenuWidget(), 
                        tag: 'Menu',
                      ),
                    ),
                  )
                  : Hero(
                    child: MenuWidget(), 
                    tag: 'Menu',
                  ), 
                ],
              ),
            ),
          ) 
        : route.screen;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Comies',
      theme: Core.ComiesTheme(context).theme,
      debugShowCheckedModeBanner: false,
      onGenerateRoute: onGeneratedRoute,
      themeMode: ThemeMode.dark,
    );
  }
}
