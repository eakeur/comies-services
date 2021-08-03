import 'package:comies/components.dart';
import 'package:comies/core.dart';
import 'package:comies/products/list-container.dart';
import 'package:datacontext/datacontext.dart';
import 'package:flutter/material.dart';

import 'product-list.dart';
import 'product-screen-bar.dart';
import 'products-controller.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  _ProductsScreenState createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> with TickerProviderStateMixin {
  late DataSet<CategoryView> categories;

  @override
  void initState() {
    super.initState();
    var prov = getProvider(context);
    categories = prov.categoryViews;
    categories.get();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Flex(
        direction: getRelativeAxis(context),
        mainAxisAlignment: MainAxisAlignment.end,
        children: [FloatingActionButton(mini: true, tooltip: 'Adicionar categoria', child: Icon(Icons.category), onPressed: () => ProductsController.showCategoryForm(context, isNew: true))],
      ),
      appBar: ProductsScreenBar(context),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: isWidthSmall(context) ? 0 : 20),
        child: LoadStatusWidget(
          status: categories.loadStatus,
          loadWidget: (context) {
            return DefaultTabController(
              length: categories.list.length + 1,
              child: ResponsiveWidget(
                flexes: [70, 30],
                children: [
                  LoadStatusWidget(
                    status: categories.loadStatus,
                    loadWidget: (context) {
                      return Column(
                        children: [
                          TabBar(
                            indicatorColor: PrimaryColor,
                            isScrollable: true,
                            tabs: [
                              ...categories.list.map((c) => Tab(text: c.name ?? 'Sem nome')).toList(),
                              Tab(text: 'Sem categoria'),
                            ],
                          ),
                          Expanded(
                            child: TabBarView(
                              children: [
                                ...categories.list.map((c) => ProductListByCategoryWidget(categoryId: c.id)).toList(),
                                ProductListByCategoryWidget(
                                  categoryId: null,
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                  Container()
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
