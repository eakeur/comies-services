import 'package:comies/core.dart';
import 'package:comies/products/products.dart';
import 'package:flutter/material.dart';

class ProductSelector extends StatelessWidget {
  final VoidCallback onCancelSearch;

  final Function(ProductFilter) onSearch;

  final Function(ProductView) onTap;

  final List<ProductView> data;

  const ProductSelector({Key? key, required this.onSearch, required this.onCancelSearch, required this.data, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ProductSearcher(onSearch: onSearch, onCancel: onCancelSearch),
            Text('Selecione abaixo o produto desejado'),
            Flexible(
              child: ProductsList(
                products: data,
                onTap: onTap,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
