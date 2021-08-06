import 'package:comies/core.dart';
import 'package:flutter/material.dart';

class ResponsiveWidget extends StatelessWidget {
  final List<int> flexes;
  final List<Widget> children;
  final CrossAxisAlignment crossAxisAlignment;
  const ResponsiveWidget({Key? key, required this.flexes, required this.children, this.crossAxisAlignment = CrossAxisAlignment.start}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var index = 0;
    return Flex(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: crossAxisAlignment,
      direction: isWidthSmall(context) ? Axis.vertical : Axis.horizontal,
      children: children.map((child) {
        index++;
        return isWidthSmall(context) ? Expanded(child: child) : Expanded(flex: flexes[index - 1], child: child);
      }).toList(),
    );
  }
}
