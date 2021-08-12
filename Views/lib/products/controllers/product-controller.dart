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
    ingredients = products.rel('ingredients', parentId: id);
  }

  void get() {
    if (id == 'new') {
      products.create(Product(creationDate: DateTime.now()));
    } else {
      products.getOne(id).then((value) => ingredients.get()).catchError((e) {
        showErrorFeedback(e, context);
      });
    }
  }

  void add() => launchFuture(products.add(), context);
  void update() => launchFuture(products.update(id), context);
  void delete() => launchFuture(products.remove(id), context);

  void addIngredient() => launchFuture(ingredients.add(ingredients.local['editingIngredient']), context);
  void updateIngredient() => launchFuture(products.update(ingredients.data!.id), context);
  void deleteIngredient([String? id]) => launchFuture(products.remove(id ?? ingredients.data!.id), context);
}
