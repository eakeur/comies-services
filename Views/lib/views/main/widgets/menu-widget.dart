import 'package:comies/core.dart';
import 'package:comies/core/models/comiesroute.dart';
import 'package:flutter/material.dart';

class MenuWidget extends StatefulWidget {
  final List<String> actualStack;

  const MenuWidget({Key key, this.actualStack}) : super(key: key);

  @override
  _MenuWidgetState createState() => _MenuWidgetState();
}

class _MenuWidgetState extends State<MenuWidget> {

  String get actualRoute => ComiesRoute.of(context).route;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: composBG, borderRadius: BorderRadius.only(topRight: Radius.circular(20), bottomRight: Radius.circular(20))),
      width: 104,
      child: Column(
        children: [],
      ),
    );
  }
}

class MenuItemWidget extends StatefulWidget {
  final bool isSelected;
  final VoidCallback onTap;
  final IconData icon;

  const MenuItemWidget({Key key, this.isSelected, this.onTap, this.icon}) : super(key: key);

  @override
  _MenuItemWidgetState createState() => _MenuItemWidgetState();
}

class _MenuItemWidgetState extends State<MenuItemWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 92,
      height: 102,
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
          bottomLeft: Radius.circular(10),
          bottomRight: Radius.circular(10),
        ),
      ),
      child: TextButton(
        onPressed: widget.onTap,
        child: Icon(widget.icon, size: 25),
        style: ButtonStyle(backgroundColor: MaterialStateProperty.all(primaryColor)),
      ),
    );
  }
}
