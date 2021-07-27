import 'package:comies/components.dart';
import 'package:comies/core.dart';
import 'package:comies/controllers/products-controller.dart';
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
    controller.loadMany();
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
            ValueListenableBuilder<LoadStatus>(
              valueListenable: controller.listStatus,
              builder: (context, status, child) {
                if (status == LoadStatus.LOADED)
                  return Card(
                      child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: ProductsList(
                        products: controller.list,
                        onTap: (prod) {
                          Navigator.pushNamed(context, '/products/${prod.id}', arguments: prod.name);
                        }),
                  ));
                return Container();
              },
            ),
            Container()
          ],
        ),
      ),
    );
  }
}
