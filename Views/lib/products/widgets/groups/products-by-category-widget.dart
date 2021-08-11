import 'package:comies/core.dart';
import 'package:comies/products/products.dart';
import 'package:datacontext/datacontext.dart';
import 'package:flutter/material.dart';

class CategoriesParentWidget extends StatefulWidget {
  const CategoriesParentWidget({Key? key}) : super(key: key);

  @override
  _CategoriesParentWidgetState createState() => _CategoriesParentWidgetState();
}

class _CategoriesParentWidgetState extends State<CategoriesParentWidget> {
  late DataSet<CategoryView> categories;

  @override
  void initState() {
    categories = ProductsController.getCategories(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LoadStatusWidget(
      status: categories.loadStatus,
      loadWidget: (context) => ProductsByCategoryWidget(categories: categories.list, loadStatus: categories.loadStatus),
    );
  }
}

class ProductsByCategoryWidget extends StatefulWidget {
  final ValueNotifier<LoadStatus> loadStatus;
  final List<CategoryView> categories;
  ProductsByCategoryWidget({Key? key, required this.loadStatus, required this.categories}) : super(key: key);

  @override
  _ProductsByCategoryWidgetState createState() => _ProductsByCategoryWidgetState();
}

class _ProductsByCategoryWidgetState extends State<ProductsByCategoryWidget> {
  Map<String, DataSet<ProductView>> productsSets = <String, DataSet<ProductView>>{};

  int get tabsLength => categories.length + 1;

  List<CategoryView> get categories => widget.categories;

  List<Tab> get categoryTabs => [...categories.map((c) => Tab(text: c.name ?? 'Sem nome')).toList(), Tab(text: 'Todos')];

  List<Widget> get productsTab => [
        ...categories.map((e) {
          var dataset = productsSets[e.id]!;
          return Container(key: PageStorageKey(e.id), child: ProductListByCategoryWidget(products: dataset.list, status: dataset.loadStatus));
        }).toList(),
        Container(key: PageStorageKey('none'), child: ProductListByCategoryWidget(products: productsSets['none']!.list, status: productsSets['none']!.loadStatus))
      ];

  @override
  void initState() {
    super.initState();
    productsSets = ProductsController.getProductViewsByCategories(context, categories);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabsLength,
      child: LoadStatusWidget(
        status: widget.loadStatus,
        loadWidget: (context) {
          return Column(
            //mainAxisSize: MainAxisSize.min,
            children: [
              TabBar(
                indicatorColor: PrimaryColor,
                isScrollable: true,
                tabs: categoryTabs,
              ),
              Expanded(
                child: TabBarView(
                  children: productsTab,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class ProductListByCategoryWidget extends StatelessWidget {
  final List<ProductView> products;
  final ValueNotifier<LoadStatus> status;

  const ProductListByCategoryWidget({Key? key, required this.products, required this.status}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: LoadStatusWidget(
          status: status,
          loadWidget: (context) {
            return ProductsList(
              products: products,
              onTap: (prod) => Navigator.pushNamed(context, '/products/${prod.id}', arguments: prod.name),
              onAddTap: () => Navigator.pushNamed(context, '/products/new', arguments: ''),
            );
          },
        ),
      ),
    );
  }
}
