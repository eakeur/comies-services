import 'package:comies/core.dart';
import 'package:flutter/material.dart';

class DefaultButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  final bool danger;
  final IconData icon;
  final bool disabled;

  const DefaultButton({Key key, this.label, this.onTap, this.danger = false, this.icon, this.disabled = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var labels = <Widget>[];
    if (icon != null)
      labels.add(Padding(
        padding: const EdgeInsets.only(right: 10),
        child: Icon(icon, size: 24, color: disabled ? primaryColor.withOpacity(0.3) : primaryColor),
      ));
    labels.add(Text(label, style: getButtonText(color: disabled ? primaryColor.withOpacity(0.3) : primaryColor)));
    return TextButton(
      onPressed: disabled ? null : onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        mainAxisSize: MainAxisSize.min,
        children: labels,
      ),
      style: ButtonStyle(
        animationDuration: Duration(milliseconds: 600),
        padding: MaterialStateProperty.all(EdgeInsets.all(14.0)),
        backgroundColor: MaterialStateProperty.all(Colors.transparent),
        overlayColor: disabled ? null : MaterialStateProperty.all(primaryColor.withOpacity(0.2)),
        shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(8), side: BorderSide(color: disabled ? primaryColor.withOpacity(0.3) : primaryColor))),
        minimumSize: MaterialStateProperty.all(Size(48, 48)),
      ),
    );
  }
}
