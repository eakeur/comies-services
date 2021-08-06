import 'package:comies/core.dart';
import 'package:flutter/material.dart';

class StockLevelWidget extends StatefulWidget {
  final double value;
  final String message;
  final bool semanticPaint;

  const StockLevelWidget({Key? key, required this.value, required this.message, this.semanticPaint = true}) : super(key: key);
  @override
  _StockLevelWidgetState createState() => _StockLevelWidgetState();
}

class _StockLevelWidgetState extends State<StockLevelWidget> with TickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation;

  double get value => widget.value / 100;

  Color get color => animation.value <= 0.33
      ? ErrorDarkColor
      : animation.value <= 0.66
          ? PrimaryColor
          : SuccessDarkColor;

  @override
  void initState() {
    controller = AnimationController(vsync: this, duration: Duration(milliseconds: 2000));
    animation = Tween<double>(begin: 0, end: value).animate(CurvedAnimation(parent: controller, curve: Curves.decelerate))..addListener(() => setState(() {}));
    controller.forward();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Expanded(
          flex: 90,
          child: LinearProgressIndicator(
            valueColor: AlwaysStoppedAnimation(color),
            value: animation.value,
          ),
        ),
        Expanded(
          flex: 10,
          child: Tooltip(
            message: widget.message,
            child: Text('${(animation.value * 100).toInt()}%', textAlign: TextAlign.right),
          ),
        ),
      ],
    );
  }
}
