import 'package:flutter/material.dart';

class Route {
  final String path;
  final String name;
  final Widget screen;
  final IconData icon;
  final bool encapsulate;
  final bool isAuth;
  final bool isSplash;
  final Function(String)? parser;
  Route({required this.path, required this.name, required this.screen, required this.icon, this.encapsulate = true, this.isAuth = false, this.isSplash = false, this.parser});
}
