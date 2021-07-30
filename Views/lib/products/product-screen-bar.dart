import 'package:comies/core.dart';
import 'package:datacontext/datacontext.dart';
import 'package:flutter/material.dart';

import 'stock-level-widget.dart';

class ProductScreenAppBar extends AppBar {

  ProductScreenAppBar({required ValueNotifier<LoadStatus> status, bool isNew = true, String name = 'Novo produto', double stockLevel = 0, required VoidCallback onCopy, required VoidCallback onDelete}): super(
    title: ValueListenableBuilder<LoadStatus>(
      valueListenable: status,
      builder: (context, status, child) => Text(name, style: getPageTitle()),
    ),
    bottom: isNew ? null : PreferredSize(
      preferredSize: Size.fromHeight(15),
      child: ValueListenableBuilder<LoadStatus>(
        valueListenable: status,
        builder: (context, status, child) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: StockLevelWidget(value: stockLevel, message: 'O nível de estoque desse produto relacionado ao seu total'),
          );
        }, 
      ),
    ),
    actions: isNew ? null : [
      IconButton(icon: Icon(Icons.delete), onPressed: onDelete, tooltip: 'Excluir produto'),
      IconButton(icon: Icon(Icons.copy), onPressed: onCopy, tooltip: 'Copiar valores para novo produto'),
    ]
  );
}
