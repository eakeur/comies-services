import 'package:comies/core.dart';
import 'package:flutter/material.dart';

/*
 * Creates an option buttons group
 */
class GroupSelection<T> extends StatelessWidget {
  final List<Selection<T>> children;

  final void Function(T) onSelectChange;

  const GroupSelection({Key key, this.children, this.onSelectChange}) : super(key: key);

  BorderRadius getSelectionBorderRadius(Selection<T> selection) {
    var isFirst = children.indexOf(selection) == 0;
    var isLast = children.indexOf(selection) == children.length - 1;
    if (isFirst) return BorderRadius.only(topLeft: Radius.circular(8), bottomLeft: Radius.circular(8));
    if (isLast) return BorderRadius.only(topRight: Radius.circular(8), bottomRight: Radius.circular(8));
    return BorderRadius.all(Radius.circular(10));
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Material(
        elevation: 4,
        color: Theme.of(context).brightness == Brightness.light ? neutralColor : null,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: children
              .map((child) => Expanded(
                  child: InkWell(
                    customBorder: RoundedRectangleBorder(borderRadius: getSelectionBorderRadius(child)),
                    onTap: () => onSelectChange(child.value),
                    child: child),
              ))
              .toList(),
        ),
      ),
    );
  }
}

class Selection<T> extends StatelessWidget {
  final T value;
  final Widget child;
  final bool selected;

  const Selection({Key key, this.child, this.selected, this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      padding: EdgeInsets.only(top: 10, bottom: 10, left: 15, right: 15),
      color: selected ? accentColor : Colors.transparent,
      curve: Curves.ease,
      duration: Duration(milliseconds: getValue<int>(context, 'ANIM_DURATION')),
      child: Center(child: child),
    );
  }
}
