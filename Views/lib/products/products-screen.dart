import 'package:comies/components.dart';
import 'package:comies/core.dart';
import 'package:datacontext/datacontext.dart';
import 'package:flutter/material.dart';

import 'product-list.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  _ProductsScreenState createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  late DataSet<ProductView> products;

  @override
  void initState() {
    products = getProvider(context).productViews;
    products.get(filters: ProductFilter().toMap());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(tooltip: 'Adicionar produto', child: Icon(Icons.add), onPressed: () => Navigator.pushNamed(context, '/products/new', arguments: '')),
      appBar: AppBar(title: Text('Produtos', style: getPageTitle())),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: isWidthSmall(context) ? 0 : 20),
        child: ResponsiveWidget(
          flexes: [30, 70],
          children: [
            LoadStatusWidget(
              status: products.loadStatus,
              initialWidget: (context) => Container(),
              loadWidget: (context) => Card(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: ProductsList(
                    products: products.list,
                    onTap: (prod) => Navigator.pushNamed(context, '/products/${prod.id}', arguments: prod.name)
                  ),
                ),
              ),
            ),
            Container()
          ],
        ),
      ),
    );
  }
}
