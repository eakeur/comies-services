import 'package:comies/core.dart';
import 'package:flutter/material.dart';
import 'models.dart';

class ProductController extends GeneralController<Product, ProductView, ProductFilter> {
  ProductController(BuildContext context) : super(context, '/products');

  @override
  ProductFilter filter = ProductFilter();

  @override
  Product Function(Map<String, dynamic> map) modelParser = (map) => Product.fromMap(map);

  @override
  Product Function() newModelParser = () => Product(creationDate: DateTime.now());

  @override
  ProductView Function(Map<String, dynamic> map) viewParser = (map) => ProductView.fromMap(map);

  // late BuildContext context;

  // late Service service;

  // late ValueNotifier<LoadStatus> productsListStatus;
  // late ValueNotifier<LoadStatus> productStatus;

  // ProductController(this.context) {
  //   service = getProvider(context).service;
  //   productsListStatus = ValueNotifier<LoadStatus>(LoadStatus.START);
  //   productStatus = ValueNotifier<LoadStatus>(LoadStatus.START);
  // }

  // List<ProductView> products = <ProductView>[];
  // Product? product;

  // List<CategoryView> categories = <CategoryView>[];
  // Category? category;

  // ProductFilter productFilter = new ProductFilter();
  // CategoryFilter categoryFilter = new CategoryFilter();

  // int _productRecords = 0;
  // int _categoryRecords = 0;

  // int get skipGettingFromProductsAPI => _productRecords - products.length;
  // bool get fetchedAllAvailableProducts => products.length == _productRecords;

  // int get skipGettingFromCategoriesAPI => _categoryRecords - categories.length;
  // bool get fetchedAllAvailableCategories => categories.length == _categoryRecords;

  // Future<List<ProductView>> loadProducts() async {
  //   try {
  //     productsListStatus.value = LoadStatus.LOADING;
  //     productFilter.skip = skipGettingFromProductsAPI;
  //     var res = await service.getMany(filter: productFilter, route: '/products');
  //     _productRecords = res.records ?? 0;
  //     products.addAll((res.data as List).map((x) => ProductView.fromMap(x as Map<String, dynamic>)));
  //     productsListStatus.value = LoadStatus.LOADED;
  //     return products;
  //   } catch (e) {
  //     print(e);
  //     productsListStatus.value = LoadStatus.FAILED;
  //     return products;
  //   }
  // }

  // Future<List<CategoryView>> loadCategories() async {
  //   try {
  //     productsListStatus.value = LoadStatus.LOADING;
  //     categoryFilter.skip = skipGettingFromCategoriesAPI;
  //     var res = await service.getMany(filter: categoryFilter, route: '/categories');
  //     _categoryRecords = res.records ?? 0;
  //     categories.addAll((res.data as List).map((x) => CategoryView.fromMap(x as Map<String, dynamic>)));
  //     productsListStatus.value = LoadStatus.LOADED;
  //     return categories;
  //   } catch (e) {
  //     print(e);
  //     productsListStatus.value = LoadStatus.FAILED;
  //     return categories;
  //   }
  // }

  // Future<Product?> loadProduct(String? id) async {
  //   try {
  //     if (id != null) {
  //       if (id == 'new') {
  //         product = Product();
  //       } else {
  //         productStatus.value = LoadStatus.LOADING;
  //         var res = await service.getOne(uniqueID: id, route: '/products');
  //         if (!res.success) showFeedback(context, title: res.message ?? '', success: res.success);
  //         product = Product.fromMap(res.data as Map<String, dynamic>);
  //       }
  //     }
  //     productStatus.value = LoadStatus.LOADED;
  //     return product;
  //   } catch (e) {
  //     print(e);
  //     productStatus.value = LoadStatus.FAILED;
  //     return product;
  //   }
  // }

  // Future<Product?> saveProduct() async {
  //   try {
  //     if (product != null) {
  //       productStatus.value = LoadStatus.LOADING;
  //       ServerResponse res;
  //       if (product!.id == null || product!.id == guidEmpty) {
  //         res = await service.addOne<Product>(product!, route: '/products');
  //         productStatus.value = res.success ? LoadStatus.LOADED : LoadStatus.FAILED;
  //       } else {
  //         res = await service.put<Product>(product!, route: '/products', uniqueID: product!.id!);
  //         productStatus.value = res.success ? LoadStatus.LOADED : LoadStatus.FAILED;
  //       }
  //       showFeedback(context, title: res.message ?? '', success: res.success);
  //     }
  //   } catch (e) {}
  //   productStatus.value = LoadStatus.LOADED;
  // }

  // Future<void> deleteProduct() async {
  //   try {
  //     if (product != null) {
  //       productStatus.value = LoadStatus.LOADING;
  //       ServerResponse res;
  //       if (product!.id != null) {
  //         res = await service.del(route: '/products', uniqueID: product!.id!);
  //         productStatus.value = res.success ? LoadStatus.LOADED : LoadStatus.FAILED;
  //         showFeedback(context, title: res.message ?? '', success: res.success);
  //         Navigator.of(context).pop();
  //       }
  //     }
  //   } catch (e) {}
  //   productStatus.value = LoadStatus.LOADED;
  // }

  // void copyProduct() {}
}
