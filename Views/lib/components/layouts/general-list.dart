import 'package:flutter/material.dart';

class GeneralList<T> extends StatelessWidget {
  final List<T> modelList;
  final Widget Function(BuildContext, int, T)? builder;
  final String Function(T)? titleGetter;
  final String Function(T)? subtitleGetter;
  final Function(T) onTap;
  final ViewType type;
  final double? itemExtent;

  const GeneralList({Key? key, required this.modelList, required this.onTap, this.itemExtent, this.type = ViewType.LIST, this.builder, this.titleGetter, this.subtitleGetter}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemExtent: itemExtent,
      itemCount: modelList.length,
      itemBuilder: (context, index) {
        var mod = modelList[index];
        if (builder != null) return builder!(context, index, mod);
        return ListTile(
          onTap: () => onTap(mod),
          title: Text(titleGetter!(mod)),
          subtitle: Text(subtitleGetter!(mod)),
        );
      },
    );
  }
}

enum ViewType { TABLE, LIST, GRID, CAROUSEL }
