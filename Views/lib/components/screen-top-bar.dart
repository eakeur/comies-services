import 'package:comies/core.dart';
import 'package:datacontext/datacontext.dart';
import 'package:flutter/material.dart';

class PageBar extends AppBar {
  PageBar({
    ValueNotifier<LoadStatus>? status,
    required String pageName,
    List<Widget>? actions,
    PreferredSizeWidget? bottom,
    VoidCallback? onCopy,
    VoidCallback? onDelete,
  }) : super(
            title: status == null
                ? Text(pageName)
                : ValueListenableBuilder<LoadStatus>(valueListenable: status, builder: (context, status, child) => Text(LoadStatus.LOADED == status ? pageName : "", style: getPageTitle())),
            bottom: bottom,
            actions: onCopy != null || onDelete != null || actions != null
                ? [
                    if (actions != null) ...actions,
                    if (onCopy != null) IconButton(icon: Icon(Icons.copy), onPressed: onDelete, tooltip: 'Copiar'),
                    if (onDelete != null) IconButton(icon: Icon(Icons.delete), onPressed: onDelete, tooltip: 'Excluir')
                  ]
                : null);
}
