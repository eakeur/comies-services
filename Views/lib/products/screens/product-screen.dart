import 'package:comies/core.dart';
import 'package:datacontext/datacontext.dart';
import 'package:flutter/material.dart';
import 'package:comies/products/products.dart';

class ProductScreen extends StatefulWidget {
  final String? id;
  final String? name;

  const ProductScreen({Key? key, this.id, this.name}) : super(key: key);

  @override
  _ProductScreenState createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  late ProductController data;

  @override
  void initState() {
    data = ProductController(context, widget.id ?? 'new');
    super.initState();
  }

  bool get isNew => widget.id == 'new';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ProductScreenAppBar(
        onCopy: () {},
        onDelete: () => data.products.remove(data.products.data!.id),
        status: data.products.loadStatus,
        isNew: isNew,
        stockLevel: 75,
        name: isNew ? 'Novo produto' : (data.products.data != null ? data.products.data!.name! : widget.name ?? ''),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: isWidthSmall(context) ? 0 : 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              LoadStatusWidget(
                status: data.products.loadStatus,
                loadWidget: (context) => Flex(
                  direction: getRelativeAxis(context),
                  children: [
                    Expanded(
                      flex: getRelativeFlex(context),
                      child: ProductForm(
                        isNew: isNew,
                        product: data.products.data,
                        onSubmit: () => isNew ? data.products.add(data.products.data!) : data.products.update(data.products.data!.id, data.products.data!),
                        submitStatus: data.products.changeStatus.value,
                      ),
                    ),
                    Expanded(
                      flex: getRelativeFlex(context),
                      child: IsNullWidget<String>(
                        value: isNew ? null : widget.id,
                        child: (context, val, child) => LoadStatusWidget(
                          status: data.ingredients.loadStatus,
                          loadWidget: (context) => IngredientsForm(
                            data: data.ingredients.data ?? Ingredient(creationDate: DateTime.now()),
                            ingredients: data.ingredients.list,
                            onSave: (ing) => data.ingredients.add(ing),
                            onDelete: (id) => data.ingredients.remove(id),
                            onEdit: (ing) => data.ingredients.data = ing,
                            onCancel: () => data.ingredients.clearModel(),
                          ),
                        ),
                        nullWidget: (context, val, child) => Container(child: Text('Aqui vão informações sobre os ingredientes')),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
