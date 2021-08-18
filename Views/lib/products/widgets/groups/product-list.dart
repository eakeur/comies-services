import 'package:comies/components.dart';
import 'package:comies/products/products.dart';
import 'package:flutter/material.dart';
import 'package:comies/core.dart';

class ProductsList extends StatelessWidget {
  final List<ProductView> products;
  final Function(ProductView) onTap;
  final VoidCallback? onAddTap;
  final bool isGrid;
  const ProductsList({Key? key, required this.products, required this.onTap, this.onAddTap, this.isGrid = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: isGrid ? Axis.horizontal : Axis.vertical,
      itemCount: isGrid || onAddTap == null ? products.length : products.length + 1,
      itemBuilder: (context, index) {
        if (index == 0 && !isGrid && onAddTap != null) return DefaultButton(label: 'Adicionar produto', onTap: onAddTap, icon: Icons.add);
        final product = (isGrid || onAddTap == null) ? products[index] : products[index - 1];
        return isGrid
            ? Container(
                height: 180,
                width: 350,
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: ProductViewWidget(prod: product, onTap: () => onTap(product)),
              )
            : Container(
                padding: EdgeInsets.symmetric(vertical: 5),
                constraints: BoxConstraints(minHeight: 95, maxHeight: 95),
                child: ProductViewWidget(prod: product, onTap: () => onTap(product)),
              );
      },
    );
  }
}

// class ProductViewWidget extends StatelessWidget {
//   const ProductViewWidget({
//     Key? key,
//     required this.prod,
//   }) : super(key: key);

//   final ProductView prod;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: Column(
//         children: [
//           Row(
//             children: [
//               Text(getTextView(prod.code), style: getSubtitleText()),
//               SizedBox(width: 20),
//               Expanded(child: Material(color: Colors.transparent, child: Text(getTextView(prod.name), style: getMainText()))),
//               SizedBox(width: 20),
//               Text('R\$ ${getCurrencyView(prod.value)}', style: getSubtitleText(), textAlign: TextAlign.right),
//             ],
//           ),
//           Padding(
//             padding: const EdgeInsets.only(top: 5),
//             child: StockLevelWidget(value: (75).toDouble(), message: 'O nível de estoque desse produto relacionado ao seu total'),
//           )
//         ],
//       ),
//     );
//   }
// }

class ProductViewWidget extends StatelessWidget {
  final ProductView prod;
  final VoidCallback onTap;
  const ProductViewWidget({Key? key, required this.prod, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Material(
        elevation: 4,
        color: ComponentBG,
        child: InkWell(
          customBorder: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          onTap: onTap,
          child: Container(
            padding: EdgeInsets.all(10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(getTextView(prod.code), style: getSubtitleText()),
                    Text('R\$ ${getCurrencyView(prod.value)}', style: getSubtitleText(), textAlign: TextAlign.right),
                  ],
                ),
                Expanded(child: Text(getTextView(prod.name), textAlign: TextAlign.left, style: getMainText())),
                Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: StockLevelWidget(value: (75).toDouble(), message: 'O nível de estoque desse produto relacionado ao seu total'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
