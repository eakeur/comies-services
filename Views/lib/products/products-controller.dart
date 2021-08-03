import 'package:comies/core.dart';
import 'package:comies/products/category-form.dart';
import 'package:datacontext/datacontext.dart';
import 'package:flutter/material.dart';

class ProductsController {
  static void getCategories(BuildContext context) {
    var provider = getProvider(context);
    var categories = provider.categories;
    var products = provider.products;
  }

  static void showCategoryForm(BuildContext context, {String? id, bool isNew = false}) {
    var cats = getProvider(context).categories;
    if (isNew) {
      cats.data = Category(creationDate: DateTime.now());
    } else {
      cats.getOne(id!);
    }

    Scaffold.of(context).showBottomSheet((context) {
      return Scaffold(
        body: LoadStatusWidget(
          status: cats.loadStatus,
          loadWidget: (context) => CategoryForm(category: cats.data, onSubmit: () => isNew ? cats.add(cats.data!) : cats.update(cats.data!.id!, cats.data!), submitStatus: cats.changeStatus.value),
        ),
      );
    });
  }
}
