import 'package:comies/components.dart';
import 'package:comies/core.dart';
import 'package:comies/products/products.dart';
import 'package:datacontext/datacontext.dart';
import 'package:flutter/material.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  _ProductsScreenState createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> with TickerProviderStateMixin {
  late DataSet<CategoryView> categories;
  late DataSet<ProductView> products;

  bool isSearching = false;

  @override
  void initState() {
    super.initState();
    categories = ProductsController.getCategories(context);
    products = getProvider(context).productViews;
  }

  void onSearch(filter) {
    setState(() => isSearching = true);
    ProductsController.searchProducts(context, filter);
  }

  void onCancel() {
    setState(() => isSearching = false);
    products.clearList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(mini: true, tooltip: 'Adicionar categoria', child: Icon(Icons.category), onPressed: () => ProductsController.showCategoryForm(context, isNew: true)),
      appBar: ProductsScreenBar(context, onSearch, onCancel),
      body: Padding(
        padding: EdgeInsets.only(top: 10, left: isWidthSmall(context) ? 5 : 20),
        child: Column(
          children: [
            if (isSearching) searchResults,
            Expanded(
              child: Container(
                //constraints: BoxConstraints(maxHeight: getHeight(context) * ),
                child: LoadStatusWidget(
                  status: categories.loadStatus,
                  loadWidget: (context) => ProductsByCategoryWidget(categories: categories.list, loadStatus: categories.loadStatus),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget get grid {
    return ResponsiveWidget(
      flexes: [70, 30],
      children: [
        LoadStatusWidget(
          status: categories.loadStatus,
          loadWidget: (context) => ProductsByCategoryWidget(categories: categories.list, loadStatus: categories.loadStatus),
        ),
        LoadStatusWidget(
          status: categories.loadStatus,
          loadWidget: (context) => ProductsByCategoryWidget(categories: categories.list, loadStatus: categories.loadStatus),
        ),
      ],
    );
  }

  Widget get searchResults {
    return Container(
      //constraints: BoxConstraints(minHeight: 100, maxHeight: 200),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Resultados da pesquisa', textAlign: TextAlign.left),
          SizedBox(height: 10),
          Container(
            constraints: BoxConstraints(minHeight: 100, maxHeight: 180),
            child: LoadStatusWidget(
              status: products.loadStatus,
              loadWidget: (context) => products.list.length > 0
                  ? ProductsList(
                      isGrid: true,
                      products: products.list,
                      onTap: (prod) => Navigator.pushNamed(context, '/products/${prod.id}', arguments: prod.name),
                      onAddTap: () => Navigator.pushNamed(context, '/products/new', arguments: ''),
                    )
                  : Container(child: Center(child: Text('Ops! Não encontramos nada com esses filtros'))),
            ),
          ),
        ],
      ),
    );
  }
}
