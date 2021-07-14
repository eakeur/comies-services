import 'package:comies/core.dart';
import 'package:flutter/material.dart';

class ResponsiveWidget extends StatelessWidget {
  final List<int> flexes;
  final List<Widget> children;
  const ResponsiveWidget({Key? key, required this.flexes, required this.children}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var index = 0;
    return Flex(
      direction: isWidthSmall(context) ? Axis.vertical : Axis.horizontal,
      children: children.map((child) {
        index++;
        return Expanded(flex: isWidthSmall(context) ? 0 : flexes[index - 1], child: child);
      }).toList(),
    );
  }
}
