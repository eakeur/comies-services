import 'package:comies/core.dart';
import 'package:flutter/material.dart';

class DefaultIconButton extends StatelessWidget {
  final String? label;
  final VoidCallback? onTap;
  final bool danger;
  final IconData? icon;
  final bool disabled;

  const DefaultIconButton({Key? key, this.label, this.onTap, this.danger = false, this.icon, this.disabled = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 48,
      height: 48,
      child: Tooltip(
        message: label ?? 'Botão',
        child: TextButton(
          onPressed: disabled ? null : onTap,
          child: Icon(icon, size: 24, color: disabled ? PrimaryColor.withOpacity(0.3) : PrimaryColor),
          style: ButtonStyle(
            animationDuration: Duration(milliseconds: 600),
            padding: MaterialStateProperty.all(EdgeInsets.all(14.0)),
            backgroundColor: MaterialStateProperty.all(Colors.transparent),
            overlayColor: disabled ? null : MaterialStateProperty.all(PrimaryColor.withOpacity(0.2)),
            shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(8), side: BorderSide(color: disabled ? PrimaryColor.withOpacity(0.3) : PrimaryColor))),
            minimumSize: MaterialStateProperty.all(Size(48, 48)),
          ),
        ),
      ),
    );
  }
}
