import 'package:flutter/material.dart';

class Route {
  final String path;

  final String name;

  final Widget Function(RouteSettings, Uri)? builder;

  final Widget? screen;

  final IconData icon;

  final bool encapsulate;

  final bool isAuth;

  final bool isSplash;

  final int? segments;

  final bool showmenu;

  const Route({
    required this.path,
    required this.name,
    this.builder,
    this.screen,
    required this.icon,
    this.encapsulate = true,
    this.isAuth = false,
    this.isSplash = false,
    required this.segments,
    this.showmenu = true,
  });

  Route copyWith({
    String? path,
    String? name,
    Widget Function(RouteSettings, Uri)? builder,
    Widget? screen,
    IconData? icon,
    bool? encapsulate,
    bool? isAuth,
    bool? isSplash,
    int? segments,
    bool? showmenu,
  }) {
    return Route(
      path: path ?? this.path,
      name: name ?? this.name,
      builder: builder ?? this.builder,
      screen: screen ?? this.screen,
      icon: icon ?? this.icon,
      encapsulate: encapsulate ?? this.encapsulate,
      isAuth: isAuth ?? this.isAuth,
      isSplash: isSplash ?? this.isSplash,
      segments: segments ?? this.segments,
      showmenu: showmenu ?? this.showmenu,
    );
  }

  @override
  String toString() {
    return 'Route(path: $path, name: $name, builder: $builder, screen: $screen, icon: $icon, encapsulate: $encapsulate, isAuth: $isAuth, isSplash: $isSplash, segments: $segments, showmenu: $showmenu)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is Route &&
      other.path == path &&
      other.name == name &&
      other.builder == builder &&
      other.screen == screen &&
      other.icon == icon &&
      other.encapsulate == encapsulate &&
      other.isAuth == isAuth &&
      other.isSplash == isSplash &&
      other.segments == segments &&
      other.showmenu == showmenu;
  }

  @override
  int get hashCode {
    return path.hashCode ^
      name.hashCode ^
      builder.hashCode ^
      screen.hashCode ^
      icon.hashCode ^
      encapsulate.hashCode ^
      isAuth.hashCode ^
      isSplash.hashCode ^
      segments.hashCode ^
      showmenu.hashCode;
  }
}
