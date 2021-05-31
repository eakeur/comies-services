import 'package:comies/core/models/comiesroute.dart';
import 'package:comies/utils/declarations/themes.dart';
import 'package:comies/views/authentication/authentication.screen.dart';
import 'package:comies/views/costumers/costumers.screen.dart';
import 'package:comies/views/home/home.screen.dart';
import 'package:comies/views/main/widgets/menu-widget.dart';
import 'package:comies/views/orders/orders.screen.dart';
import 'package:comies/views/orders/panel.screen.dart';
import 'package:comies/views/products/products.screen.dart';
import 'package:comies/views/settings/settings.screen.dart';
import 'package:comies/views/splash/splash-screen.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  Route onRegeneratedRoute(RouteSettings route) {
    switch (route.name) {
      case '/home':
        return MaterialPageRoute(builder: (context) {
          return ScreenPlaceholder(child: HomeScreen(), route: route.name);
        });

      case '/products':
        return MaterialPageRoute(builder: (context) {
          return ScreenPlaceholder(child: ProductsScreen(), route: route.name);
        });

      case '/authentication':
        return MaterialPageRoute(builder: (context) {
          return ScreenPlaceholder(child: AuthenticationScreen(), route: route.name);
        });

      case '/costumers':
        return MaterialPageRoute(builder: (context) {
          return ScreenPlaceholder(child: CostumersScreen(), route: route.name);
        });

      case '/orders':
        return MaterialPageRoute(builder: (context) {
          return ScreenPlaceholder(child: OrdersScreen(), route: route.name);
        });

      case '/settings':
        return MaterialPageRoute(builder: (context) {
          return ScreenPlaceholder(child: SettingsScreen(), route: route.name);
        });

      case '/panel':
        return MaterialPageRoute(builder: (context) {
          return ScreenPlaceholder(child: OrdersPanelScreen(), route: route.name);
        });

      default:
        return MaterialPageRoute(builder: (context) {
          return ScreenPlaceholder(child: HomeScreen(), route: route.name);
        });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Comies',
      theme: mainTheme(Brightness.dark),
      onGenerateRoute: onRegeneratedRoute,
      themeMode: ThemeMode.dark,
      home: SplashScreen(),
    );
  }
}

class ScreenPlaceholder extends StatelessWidget {
  final Widget child;
  final String route;

  const ScreenPlaceholder({Key key, this.child, this.route}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ComiesRoute(
        route: route,
        child: Row(
          children: [Hero(child: MenuWidget(), tag: 'Menu'), Expanded(child: child)],
        ),
      )
    );
  }
}
