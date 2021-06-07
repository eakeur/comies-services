import 'package:comies/core.dart' show Route;
import 'package:comies/screens.dart';
import 'package:flutter/material.dart' show Icons;

List<Route> routes = [
  Route(
    path: '/', name: '', segments: 0, 
    icon: Icons.home, encapsulate: false, 
    isSplash: true, screen: SplashScreen()
  ),
  Route(
    path: '/auth',
    name: 'Autenticação',
    segments: 1,
    icon: Icons.lock,
    isAuth: true,
    screen: AuthenticationScreen(),
  ),
  Route(
    path: '/home',
    name: 'Início',
    icon: Icons.home_rounded,
    segments: 1,
    screen: HomeScreen(),
  ),
  Route(
    path: '/products',
    name: 'Produtos',
    icon: Icons.fastfood_rounded,
    screen: ProductsScreen(),
    segments: 1
  ),
  Route(
    path: '/products',
    name: 'Detalhes do produto',
    icon: Icons.fastfood_rounded,
    segments: 2,
    showmenu: false,
    builder: (settings, uri) => ProductScreen(id: uri.pathSegments[1], name: (settings.arguments ?? '') as String),
  ),
  Route(
    path: '/orders',
    name: 'Pedidos',
    icon: Icons.post_add_rounded,
    screen: HomeScreen(),
    segments: 1
  ),
  Route(
    path: '/customers',
    name: 'Clientes',
    icon: Icons.people_rounded,
    screen: HomeScreen(),
    segments: 1,
  ),
];
