import 'package:collection/collection.dart';
import 'package:comies/core.dart';
import 'package:flutter/material.dart';

import 'models.dart';

class ProductController {
  late BuildContext context;

  late Service service;

  late ValueNotifier<LoadStatus> productsListStatus;
  late ValueNotifier<LoadStatus> productStatus;

  ProductController(this.context) {
    service = getProvider(context).service;
    productsListStatus = ValueNotifier<LoadStatus>(LoadStatus.START);
    productStatus = ValueNotifier<LoadStatus>(LoadStatus.START);
  }

  List<ProductView> products = <ProductView>[];
  Product? product;

  ProductFilter productFilter = new ProductFilter();

  int _records = 0;

  int get skipGettingFromAPI => _records - products.length;
  bool get fetchedAllAvailable => products.length == _records;

  Future<List<ProductView>> loadProducts() async {
    try {
      productsListStatus.value = LoadStatus.LOADING;
      productFilter.skip = skipGettingFromAPI;
      var res = await service.getMany(filter: productFilter, route: '/products');
      _records = res.records ?? 0;
      products.addAll((res.data as List).map((x) => ProductView.fromMap(x as Map<String, dynamic>)));
      productsListStatus.value = LoadStatus.LOADED;
      return products;
    } catch (e) {
      print(e);
      productsListStatus.value = LoadStatus.FAILED;
      return products;
    }
  }

  Future<Product?> loadProduct(String? id) async {
    try {
      productStatus.value = LoadStatus.LOADING;
      if (id != null) {
        var res = await service.getOne(uniqueID: id, route: '/products');
        product = Product.fromMap(res.data as Map<String, dynamic>);
      }
      productStatus.value = LoadStatus.LOADED;
      return product;
    } catch (e) {
      print(e);
      productStatus.value = LoadStatus.FAILED;
      return product;
    }
  }
}
