import 'package:comies/components/screen-top-bar.dart';
import 'package:comies/core.dart';
import 'package:comies/products/products.dart';
import 'package:datacontext/datacontext.dart';
import 'package:flutter/material.dart';

import 'stock-level-widget.dart';

class ProductScreenAppBar extends AppBar {
  ProductScreenAppBar({required ValueNotifier<LoadStatus> status, bool isNew = true, String name = 'Novo produto', double stockLevel = 0, required VoidCallback onCopy, required VoidCallback onDelete})
      : super(
            title: ValueListenableBuilder<LoadStatus>(
              valueListenable: status,
              builder: (context, status, child) => Text(name, style: getPageTitle()),
            ),
            bottom: isNew ? null : null,
            // : PreferredSize(
            //     preferredSize: Size.fromHeight(15),
            //     child: ValueListenableBuilder<LoadStatus>(
            //       valueListenable: status,
            //       builder: (context, status, child) {
            //         return Padding(
            //           padding: const EdgeInsets.only(bottom: 8.0),
            //           child: StockLevelWidget(value: stockLevel, message: 'O nível de estoque desse produto relacionado ao seu total'),
            //         );
            //       },
            //     ),
            //   ),
            actions: isNew
                ? null
                : [
                    IconButton(icon: Icon(Icons.delete), onPressed: onDelete, tooltip: 'Excluir produto'),
                  ]);
}

class ProductsScreenBar extends PageBar {
  ProductsScreenBar(BuildContext context, Function(ProductFilter) onSearch, VoidCallback onCancelSearch)
      : super(
          pageName: 'Produtos',
          actions: isWidthSmall(context)
              ? null
              : [
                  SizedBox(
                    child: Padding(padding: const EdgeInsets.only(top: 8.0), child: ProductSearcher(onSearch: onSearch, onCancel: onCancelSearch)),
                    width: MediaQuery.of(context).size.width * 0.6,
                  ),
                ],
          bottom: isWidthSmall(context)
              ? PreferredSize(preferredSize: Size.fromHeight(80), child: Padding(padding: const EdgeInsets.only(top: 2.0), child: ProductSearcher(onSearch: onSearch, onCancel: onCancelSearch)))
              : null,
        );
}
