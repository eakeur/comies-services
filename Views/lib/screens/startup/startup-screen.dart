import 'package:comies/core.dart' as Core;
import 'package:comies/routes.dart';
import 'package:flutter/material.dart';
import 'package:comies/components.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  Core.Route notFound = Core.Route(segments: 1, path: '/notfound', name: 'Não encontrado', screen: Container(child: Text('404')), icon: Icons.home);

  Core.Route getRoute(Uri uri) {
    String pathTo = '';
    for (var path in uri.pathSegments) {
      pathTo += '/$path';
      var res = routes.where((r) => r.path == pathTo && r.segments == uri.pathSegments.length);
      if (res.isNotEmpty) return res.first;
    }
    if (uri.path == '/') return routes.firstWhere((r) => r.segments == 0 && r.path == '/', orElse: () => notFound);
    return notFound;
  }

  Route onGeneratedRoute(RouteSettings settings) {
    var path = settings.name ?? '';
    var uri = Uri.parse(path == '' ? '/' : path);
    var route = getRoute(uri);
    var widget = route.builder != null ? route.builder!(settings, uri) : route.screen ?? notFound.screen;
    return MaterialPageRoute(
      settings: settings,
      builder: (context) {
        return route.encapsulate ? LayoutBuilder(child: widget ?? notFound.screen!) : widget ?? notFound.screen!;
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

class LayoutBuilder extends StatelessWidget {
  final Widget child;
  const LayoutBuilder({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var padding = EdgeInsets.only(left: Core.isWidthSmall(context) ? 7 : 80, right: 7, bottom: Core.isWidthSmall(context) ? 80 : 7);
    var menu = Hero(child: MenuWidget(), tag: 'Menu');
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Container(padding: padding, child: child),
            Core.isWidthSmall(context) ? Positioned.fill(child: Align(alignment: Alignment.bottomCenter, child: menu)) : menu,
          ],
        ),
      ),
    );
  }
}
