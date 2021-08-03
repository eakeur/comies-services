import 'package:comies/core.dart';
import 'package:datacontext/datacontext.dart';
import 'package:flutter/material.dart';

import 'product-list.dart';

class ProductListByCategoryWidget extends StatefulWidget {
  final String? categoryId;
  const ProductListByCategoryWidget({Key? key, required this.categoryId}) : super(key: key);

  @override
  _ProductListWidgetState createState() => _ProductListWidgetState();
}

class _ProductListWidgetState extends State<ProductListByCategoryWidget> {
  late DataSet<ProductView> products;

  @override
  void initState() {
    products = getProvider(context).productViews.replicate();
    if (widget.categoryId != null)
      products.get(filters: ProductFilter(categoryId: widget.categoryId).toMap());
    else
      products.get();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: LoadStatusWidget(
          status: products.loadStatus,
          loadWidget: (context) {
            return ProductsList(
              products: products.list,
              onTap: (prod) => Navigator.pushNamed(context, '/products/${prod.id}', arguments: prod.name),
              onAddTap: () => Navigator.pushNamed(context, '/products/new', arguments: ''),
            );
          },
        ),
      ),
    );
  }
}
