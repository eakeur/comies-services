import 'package:comies/core.dart';
import 'package:datacontext/datacontext.dart';
import 'package:flutter/material.dart';

class ProductController {
  final BuildContext context;

  final String id;

  late DataSet<Product> products;

  late DataSet<Ingredient> ingredients;

  ProductController(this.context, [this.id = 'new']) {
    products = getProvider(context).products;
    if (id != 'new') ingredients = products.rel('ingredients', parentId: id);
  }

  Future<void> get() async {
    await products.getOne(id);
    ingredients.get();
  }
}
