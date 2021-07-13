import 'package:comies/core.dart';
import 'package:comies/products/controller.dart';
import 'package:comies/products/widgets/widgets.dart';
import 'package:flutter/material.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  _ProductsScreenState createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  late ProductController controller;

  @override
  void initState() {
    controller = ProductController(context);
    controller.loadProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      floatingActionButton: FloatingActionButton(tooltip: 'Adicionar produto', child: Icon(Icons.add),onPressed: () => Navigator.pushNamed(context, '/products/new', arguments: '')),
      appBar: AppBar(title: Text('Produtos', style: getPageTitle())),
      body: Row(
        children: [
          Expanded(
            flex: 30,
            child: ValueListenableBuilder<LoadStatus>(
              valueListenable: controller.productsListStatus,
              builder: (context, status, child) {
                if (status == LoadStatus.LOADED) return Card(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: ProductsList(products: controller.products, onTap: (prod){
                      Navigator.pushNamed(context, '/products/${prod.id}', arguments: prod.name);
                    }),
                  )
                );
                return Container();
              },
            ),
          ),
          Expanded(
            flex: 40,
            child: Container()
          )
        ],
      ),
    );
  }
}
