import 'package:comies/components.dart';
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
    data.get();
    super.initState();
  }

  bool get isNew => widget.id == 'new';

  PreferredSizeWidget get appBar {
    return ProductScreenAppBar(
      onCopy: () {},
      onDelete: () => data.products.remove(data.products.data!.id),
      status: data.products.loadStatus,
      isNew: isNew,
      stockLevel: 75,
      name: isNew ? 'Novo produto' : (widget.name ?? ''),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
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
                      child: FormContainer(isNew: isNew, data: data),
                    ),
                    Expanded(
                      flex: getRelativeFlex(context),
                      child: IngredientsContainer(isNew: isNew, data: data),
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

class FormContainer extends StatelessWidget {
  const FormContainer({
    Key? key,
    required this.isNew,
    required this.data,
  }) : super(key: key);

  final bool isNew;
  final ProductController data;

  @override
  Widget build(BuildContext context) {
    return ProductForm(
      isNew: isNew,
      product: data.products.data,
      onSubmit: isNew ? data.add : data.update,
      submitStatus: data.products.changeStatus.value,
    );
  }
}

class IngredientsContainer extends StatelessWidget {
  const IngredientsContainer({
    Key? key,
    required this.isNew,
    required this.data,
  }) : super(key: key);

  final bool isNew;
  final ProductController data;

  @override
  Widget build(BuildContext context) {
    return IsNullWidget<String>(
      value: isNew ? null : '',
      child: (context, val, child) => LoadStatusWidget(
        status: data.ingredients.loadStatus,
        loadWidget: (context) => Container(
          child: Column(
            children: [
              Text('Ingredientes', style: getSubtitleText(size: 16)),
              DataTable(
                columns: ['Quantidade', 'Ingrediente', 'Ações'].map((c) => DataColumn(label: Text(c), tooltip: c)).toList(),
                rows: data.ingredients.list
                    .map(
                      (p) => DataRow(
                        cells: <DataCell>[
                          DataCell(Text(getDoubleView(p.quantity, 2))),
                          DataCell(Text(getTextView(p.component?.name))),
                          DataCell(
                            Row(
                              children: [
                                IconButton(
                                    tooltip: 'Acessar ingrediente',
                                    onPressed: () {
                                      Navigator.pushNamed(context, '/products/${p.component!.id}', arguments: p.component?.name ?? '');
                                    },
                                    icon: Icon(Icons.navigate_next)),
                                IconButton(tooltip: 'Editar ingrediente', onPressed: () => openIngredientForm(context, p), icon: Icon(Icons.edit)),
                                IconButton(tooltip: 'Excluir ingrediente', onPressed: () => data.deleteIngredient(p.id), icon: Icon(Icons.delete))
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                    .toList(),
              ),
              DefaultButton(label: 'Adicionar ingrediente', onTap: () => openIngredientForm(context), icon: Icons.add)
            ],
          ),
        ),
      ),
      nullWidget: (context, val, child) => Container(child: Text('Aqui vão informações sobre os ingredientes')),
    );
  }

  void openIngredientForm(BuildContext context, [Ingredient? ingredient]) {
    if (ingredient == null) {
      data.ingredients.create(Ingredient(creationDate: DateTime.now()));
    } else {
      data.ingredients.data = ingredient;
    }
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      elevation: 24,
      builder: (context) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: new BorderRadius.only(topLeft: const Radius.circular(25.0), topRight: const Radius.circular(25.0)),
          ),
          margin: EdgeInsets.only(left: getWidth(context) * (isWidthSmall(context) ? 0 : 0.6)),
          child: Scaffold(
            appBar: AppBar(
              title: Text(ingredient == null ? 'Novo ingrediente' : 'Ingrediente: ' + ingredient.component!.name!),
            ),
            body: IngredientForm(
              isNew: ingredient == null,
              ingredient: data.ingredients.data,
              onSubmit: data.ingredients.data!.id != guidEmpty ? data.updateIngredient : data.addIngredient,
              submitStatus: LoadStatus.LOADED,
            ),
          ),
        );
      },
    );
  }
}
