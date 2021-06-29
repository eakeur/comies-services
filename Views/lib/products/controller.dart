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
      if (id != null) {
        if (id == 'new') {
          product = Product.empty(creationDate: DateTime.now());
        } else {
          productStatus.value = LoadStatus.LOADING;
          var res = await service.getOne(uniqueID: id, route: '/products');
          if (!res.success) showFeedback(context, title: res.message ?? '', success: res.success);
          product = Product.fromMap(res.data as Map<String, dynamic>);
        }
      }
      productStatus.value = LoadStatus.LOADED;
      return product;
    } catch (e) {
      print(e);
      productStatus.value = LoadStatus.FAILED;
      return product;
    }
  }

  Future<Product?> saveProduct() async {
    try {
      if (product != null) {
        productStatus.value = LoadStatus.LOADING;
        ServerResponse res;
        if (product!.id == null) {
          res = await service.addOne<Product>(product!, route: '/products');
          productStatus.value = res.success ? LoadStatus.LOADED : LoadStatus.FAILED;
        } else {
          res = await service.put<Product>(product!, route: '/products', uniqueID: product!.id!);
          productStatus.value = res.success ? LoadStatus.LOADED : LoadStatus.FAILED;
        }
        showFeedback(context, title: res.message ?? '', success: res.success);
      }
    } catch (e) {}
    productStatus.value = LoadStatus.LOADED;
  }

  void copyProduct() {
    
  }
}
