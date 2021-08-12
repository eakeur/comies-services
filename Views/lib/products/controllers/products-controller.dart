import 'package:comies/core.dart';
import 'package:comies/products/products.dart';
import 'package:datacontext/datacontext.dart';
import 'package:flutter/material.dart';

class ProductsController {
  static DataSet<CategoryView> getCategories(BuildContext context) {
    var prov = getProvider(context).categoryViews;
    prov.get();
    return prov;
  }

  static DataSet<ProductView> getProductsToNewDataSet(BuildContext context, [ProductFilter? filter]) {
    var dataset = getProvider(context).productViews.replicate();
    if (filter != null)
      dataset.get(filters: filter.toMap());
    else
      dataset.get();
    return dataset;
  }

  static void searchProductsToLocalStorage(BuildContext context, ProductFilter filter, {String dataIdentifier = 'searchResults'}) {
    var prov = getProvider(context).productViews;
    prov.get(filters: filter.toMap()).then((value) => prov.local[dataIdentifier] = value);
  }

  static searchProducts(BuildContext context, ProductFilter filter) {
    if ((filter.code != null && filter.code?.trim() != '') || (filter.name != null && filter.name?.trim() != '') || (filter.tag != null && filter.tag?.trim() != '')) {
      var prov = getProvider(context).productViews;
      prov.clearList();
      prov.get(filters: filter.toMap());
    }
  }

  static DataSet<Product> getProduct(BuildContext context, [String? id]) {
    var dataset = getProvider(context).products;
    dataset.clearModel();
    if (id != null && id != 'new') {
      dataset.getOne(id).then((p) {
        dataset.rel<Ingredient>('ingredients', parentId: p.id).get();
      });
    } else
      dataset.data = Product(creationDate: DateTime.now());
    return dataset;
  }

  static Map<String, DataSet<ProductView>> getProductViewsByCategories(BuildContext context, List<CategoryView> categories) {
    var map = <String, DataSet<ProductView>>{};
    categories.forEach((c) => map[c.id!] = ProductsController.getProductsToNewDataSet(context, ProductFilter(categoryId: c.id)));
    map['none'] = ProductsController.getProductsToNewDataSet(context);
    return map;
  }

  static void showCategoryForm(BuildContext context, {String? id, bool isNew = false}) {
    var cats = getProvider(context).categories;
    if (isNew) {
      cats.data = Category(creationDate: DateTime.now());
    } else {
      cats.getOne(id!);
    }

    Scaffold.of(context).showBottomSheet((context) {
      return Container(
        color: ScreenBG,
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: LoadStatusWidget(
              status: cats.loadStatus,
              loadWidget: (context) => CategoryForm(category: cats.data, onSubmit: () => isNew ? cats.add(cats.data!) : cats.update(cats.data!.id!, cats.data!), submitStatus: cats.changeStatus.value),
            ),
          ),
        ),
      );
    });
  }
}
