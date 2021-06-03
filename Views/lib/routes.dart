import 'package:comies/core.dart' show Route;
import 'package:comies/screens.dart';
import 'package:flutter/material.dart' show Icons;

List<Route> routes = [
  Route(path: '/', name: '', icon: Icons.home, screen: SplashScreen(), encapsulate: false, isSplash: true),
  Route(path: '/home', name: 'Início', icon: Icons.home_rounded, screen: HomeScreen()),
  Route(path: '/products', name: 'Produtos', icon: Icons.fastfood_rounded , screen: HomeScreen()),
  Route(path: '/orders', name: 'Pedidos', icon: Icons.post_add_rounded, screen: HomeScreen()),
  Route(path: '/customers', name: 'Clientes', icon: Icons.people_rounded, screen: HomeScreen()),
  Route(path: '/auth', name: 'Autenticação', icon: Icons.lock, screen: AuthenticationScreen(), isAuth: true),
];
