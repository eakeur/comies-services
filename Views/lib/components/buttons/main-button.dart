import 'package:comies/core.dart';
import 'package:flutter/material.dart';

class MainButton extends StatefulWidget {
  final String label;
  final String loadingLabel;
  final VoidCallback onTap;
  final bool isLoading;
  final bool danger;
  final IconData icon;
  final bool disabled;

  const MainButton({Key key, this.label, this.onTap, this.isLoading = false, this.loadingLabel, this.danger = false, this.icon, this.disabled = false}) : super(key: key);

  @override
  _MainButtonState createState() => _MainButtonState();
}

class _MainButtonState extends State<MainButton> with TickerProviderStateMixin {
  AnimationController _buttonColorController;
  Animation<Color> _buttonAnimation;
  AnimationController _textColorController;
  Animation<Color> _textAnimation;

  @override
  void initState() {
    _buttonColorController = new AnimationController(vsync: this, duration: Duration(milliseconds: 700));
    _buttonAnimation = ColorTween(begin: primaryColor, end: Colors.transparent).animate(_buttonColorController)
      ..addListener(() {
        setState(() {});
      });
    _textColorController = new AnimationController(vsync: this, duration: Duration(milliseconds: 700));
    _textAnimation = ColorTween(begin: Color(0xFFFAFAFA), end: primaryColor).animate(_textColorController)
      ..addListener(() {
        setState(() {});
      });
    super.initState();
  }

  @override
  void didUpdateWidget(MainButton oldWidget) {
    if (widget.isLoading && !widget.disabled) {
      _buttonColorController.repeat(reverse: true);
      _textColorController.repeat(reverse: true);
    } else if (!widget.disabled){
      if (_buttonColorController.status == AnimationStatus.forward) _buttonColorController.animateBack(0);
      if (_buttonColorController.status == AnimationStatus.reverse) _buttonColorController.animateTo(0);
      if (_textColorController.status == AnimationStatus.forward) _textColorController.animateBack(0);
      if (_textColorController.status == AnimationStatus.reverse) _textColorController.animateTo(0);
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _buttonColorController.dispose();
    _textColorController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: _buttonAnimation,
        builder: (context, child) {
          var labels = <Widget>[];
          if (widget.icon != null)
            labels.add(Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Icon(widget.icon, size: 20, color: widget.disabled ? Color(0xFFFAFAFA).withOpacity(0.5) : _textAnimation.value),
            ));
          labels.add(Text(widget.isLoading ? widget.loadingLabel ?? widget.label : widget.label, style: getButtonText(color: widget.disabled ? Color(0xFFFAFAFA).withOpacity(0.5) : _textAnimation.value)));
          return TextButton(
            onPressed: widget.disabled ? null : widget.onTap,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: labels,
            ),
            style: ButtonStyle(
              animationDuration: Duration(milliseconds: 600),
              padding: MaterialStateProperty.all(EdgeInsets.all(14.0)),
              shadowColor: MaterialStateProperty.all(widget.disabled ? black : _buttonAnimation.value),
              elevation: _HoverHandler(),
              backgroundColor: MaterialStateProperty.all(widget.disabled ? primaryColor.withOpacity(0.3) : _buttonAnimation.value),
              shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(8), side: BorderSide(color: primaryColor))),
              minimumSize: MaterialStateProperty.all(Size(48, 48)),
            ),
          );
        });
  }
}

class _HoverHandler extends MaterialStateProperty<double> {
  @override
  double resolve(Set<MaterialState> states) {
    if (states.contains(MaterialState.hovered))
      return 24;
    else
      return 16;
  }
}
