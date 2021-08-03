import 'package:comies/components.dart';
import 'package:flutter/material.dart';
import 'package:comies/core.dart';
import 'stock-level-widget.dart';

class ProductsList extends StatelessWidget {
  final List<ProductView> products;
  final Function(ProductView) onTap;
  final VoidCallback onAddTap;
  const ProductsList({Key? key, required this.products, required this.onTap, required this.onAddTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: products.length + 1,
      itemBuilder: (context, index) {
        if (index == 0) {
          return DefaultButton(label: 'Adicionar produto', onTap: onAddTap, icon: Icons.add);
        }
        return InkWell(
          onTap: () => onTap(products[index - 1]),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
            child: ProductViewWidget(prod: products[index - 1]),
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
              Text(getTextView(prod.code), style: getSubtitleText()),
              SizedBox(width: 20),
              Expanded(child: Material(color: Colors.transparent, child: Text(getTextView(prod.name), style: getMainText()))),
              SizedBox(width: 20),
              Text('R\$ ${getCurrencyView(prod.value)}', style: getSubtitleText(), textAlign: TextAlign.right),
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
