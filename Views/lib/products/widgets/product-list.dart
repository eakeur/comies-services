import 'package:flutter/material.dart';
import 'package:comies/core.dart';
import 'package:comies/products/models.dart';

import 'widgets.dart';

class ProductsList extends StatelessWidget {
  final List<ProductView> products;
  final Function(ProductView) onTap;
  const ProductsList({Key? key, required this.products, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemExtent: 80,
      itemCount: products.length,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () => onTap(products[index]),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
            child: ProductViewWidget(prod: products[index]),
          ),
        );
      },
    );
  }
}

class ProductViewWidget extends StatelessWidget {
  const ProductViewWidget({
    Key? key,
    required this.prod,
  }) : super(key: key);

  final ProductView prod;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Row(
            children: [
              Text(prod.code, style: getSubtitleText()),
              SizedBox(width: 20),
              Expanded(child: Material(color: Colors.transparent, child: Text(prod.name, style: getMainText()))),
              SizedBox(width: 20),
              Text('R\$ ${prod.value.toString()}', style: getSubtitleText(), textAlign: TextAlign.right),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 5),
            child: StockLevelWidget(value: (75).toDouble(), message: 'O nível de estoque desse produto relacionado ao seu total'),
          )
        ],
      ),
    );
  }
}
