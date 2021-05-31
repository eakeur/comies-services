import 'package:flutter/material.dart';

class ComiesRoute extends StatelessWidget {

  final Widget child;
  final String route;

  ComiesRoute({Key key, this.child, this.route}) : super(key: key);

  static ComiesRoute of(BuildContext context) {
    return context.findAncestorWidgetOfExactType<ComiesRoute>();
  }

  @override
  Widget build(BuildContext context) {
    return child;
  }
}
