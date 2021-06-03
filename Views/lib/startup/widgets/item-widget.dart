import 'package:comies/core.dart';
import 'package:flutter/material.dart';

class MenuItemWidget extends StatefulWidget {
  final bool isSelected;
  final bool isAfterSelected;
  final bool isBeforeSelected;
  final VoidCallback onTap;
  final IconData icon;
  final String title;
  final AnimationController controller;

  const MenuItemWidget(
      {Key? key, required this.isSelected, required this.onTap, required this.icon, required this.title, this.isAfterSelected = false, this.isBeforeSelected = false, required this.controller})
      : super(key: key);

  @override
  _MenuItemWidgetState createState() => _MenuItemWidgetState();
}

class _MenuItemWidgetState extends State<MenuItemWidget> with TickerProviderStateMixin {
  late Animation<Color?> boxFocus;
  late Animation<Color?> backgroundFocus;
  late Animation<Color?> fontColorFocus;
  late Animation<double> borderRadiusFocus;

  @override
  void initState() {
    boxFocus = ColorTween(begin: ComponentBG, end: PrimaryColor).animate(CurvedAnimation(parent: widget.controller, curve: Curves.fastOutSlowIn))..addListener(() => setState(() {}));
    backgroundFocus = ColorTween(begin: ComponentBG, end: ScreenBG).animate(CurvedAnimation(parent: widget.controller, curve: Curves.fastOutSlowIn))..addListener(() => setState(() {}));
    fontColorFocus = ColorTween(begin: PrimaryColor, end: White).animate(CurvedAnimation(parent: widget.controller, curve: Curves.fastOutSlowIn))..addListener(() => setState(() {}));
    borderRadiusFocus = Tween<double>(begin: 0, end: 10).animate(CurvedAnimation(parent: widget.controller, curve: Curves.fastOutSlowIn))..addListener(() => setState(() {}));
    if (widget.isSelected) widget.controller.forward();
    super.initState();
  }

  @override
  void didUpdateWidget(MenuItemWidget oldWidget) {
    if (widget.isSelected) widget.controller.forward();
    super.didUpdateWidget(oldWidget);
  }

  BoxDecoration get containerDecoration => BoxDecoration(
        color: widget.isSelected ? backgroundFocus.value : ComponentBG,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(widget.isSelected ? borderRadiusFocus.value : 0),
          topRight: Radius.circular(widget.isAfterSelected
              ? 10
              : widget.isSelected
                  ? 10
                  : 0),
          bottomLeft: Radius.circular(widget.isSelected ? borderRadiusFocus.value : 0),
          bottomRight: Radius.circular(widget.isBeforeSelected
              ? 10
              : widget.isSelected
                  ? 10
                  : 0),
        ),
      );
  double get containerSize => isWidthSmall(context) ? 50 : 60;
  double get iconSize => isWidthSmall(context) ? 20 : 25;

  

  BoxDecoration get glowingContainerStyle => BoxDecoration(
      color: widget.isSelected ? boxFocus.value : ComponentBG,
      borderRadius: BorderRadius.circular(10),
      boxShadow: widget.isSelected ? [BoxShadow(color: boxFocus.value!.withOpacity(0.3), spreadRadius: 2, blurRadius: 7, offset: Offset(0, 3))] : null);

  ButtonStyle get iconButtonStyle => ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.transparent), overlayColor: MaterialStateProperty.all(Colors.transparent));

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: boxFocus,
        builder: (context, child) {
          return Container(
            width: containerSize,
            height: containerSize,
            padding: EdgeInsets.all(6),
            decoration: containerDecoration,
            child: Tooltip(
              message: widget.title,
              child: Container(
                decoration: glowingContainerStyle,
                padding: EdgeInsets.all(8),
                child: Center(
                  child: TextButton(onPressed: widget.onTap, child: Icon(widget.icon, size: iconSize, color: widget.isSelected ? fontColorFocus.value : PrimaryColor), style: iconButtonStyle),
                ),
              ),
            ),
          );
        });
  }
}
