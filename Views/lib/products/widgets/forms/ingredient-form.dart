import 'package:comies/core.dart';
import 'package:comies/products/products.dart';
import 'package:datacontext/datacontext.dart';
import 'package:flutter/material.dart';

class IngredientsForm extends StatefulWidget {
  final void Function(Ingredient) onSave;

  final void Function(Ingredient) onDelete;

  final void Function(Ingredient) onEdit;

  final void Function() onCancel;

  final Ingredient data;

  final List<Ingredient> ingredients;

  const IngredientsForm({
    Key? key,
    required this.data,
    required this.ingredients,
    required this.onSave,
    required this.onDelete,
    required this.onEdit,
    required this.onCancel,
  }) : super(key: key);

  @override
  _IngredientsFormState createState() => _IngredientsFormState();
}

class _IngredientsFormState extends State<IngredientsForm> {
  final GlobalKey<FormState> formState = GlobalKey<FormState>();

  int editIndex = -1;

  Ingredient? editionBackup;

  void onEdit(Ingredient p) {
    formState.currentState?.reset();
    widget.onEdit(p);
    setState(() {
      editIndex = widget.ingredients.indexOf(p);
    });
  }

  void onCancel() {
    formState.currentState?.reset();
    widget.onCancel();
    setState(() {
      editIndex = -1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text('Ingredientes', style: getSubtitleText(size: 16)),
          DataTable(
            columns: ['Quantidade', 'Ingrediente', 'Ações'].map((c) => DataColumn(label: Text(c), tooltip: c)).toList(),
            rows: [
              ...widget.ingredients.map((p) {
                return editIndex != widget.ingredients.indexOf(p)
                    ? DataExibitionRow(ingredient: p, onEdit: () => onEdit(p), onDelete: () => widget.onDelete(p), context: context)
                    : DataEditionRow(ingredient: p, onSave: () => widget.onSave(p), onCancel: onCancel, context: context);
              }).toList(),
              DataEditionRow(
                ingredient: widget.data,
                onSave: () => widget.onSave(widget.data),
                onCancel: onCancel,
                context: context,
              ),
            ],
          ),
        ],
      ),
    );
  }

  bool get isEdition => editIndex != -1;
}

class DataEditionRow extends DataRow {
  DataEditionRow({
    required Ingredient ingredient,
    required VoidCallback onSave,
    required VoidCallback onCancel,
    required BuildContext context,
  }) : super(
          cells: <DataCell>[
            DataCell(
              TextFormField(
                onChanged: (s) => ingredient.quantity = getDoubleValue(s),
                initialValue: getDoubleView(ingredient.quantity, 2),
              ),
            ),
            DataCell(
              TextButton(
                  child: Text('Selecionar'),
                  onPressed: () {
                    showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return LoadStatusWidget(
                            status: getProvider(context).productViews.loadStatus,
                            loadWidget: (context) => ProductSelector(
                              data: getProvider(context).productViews.local['selectorResults'] ?? [],
                              onSearch: (f) => ProductsController.searchProductsToLocalStorage(context, f, dataIdentifier: 'selectorResults'),
                              onCancelSearch: () => Navigator.pop(context),
                              onTap: (p) {
                                ingredient.ingredientId = p.id;
                                Navigator.pop(context);
                              },
                            ),
                          );
                        });
                  }),
            ),
            DataCell(
              Row(
                children: [
                  IconButton(onPressed: onSave, icon: Icon(Icons.save)),
                  IconButton(onPressed: onCancel, icon: Icon(Icons.cancel)),
                ],
              ),
            ),
          ],
        );
}

class DataExibitionRow extends DataRow {
  DataExibitionRow({
    required Ingredient ingredient,
    required VoidCallback onEdit,
    required VoidCallback onDelete,
    required BuildContext context,
  }) : super(cells: <DataCell>[
          DataCell(Text(getDoubleView(ingredient.quantity, 2))),
          DataCell(Text(getTextView(ingredient.component?.name))),
          DataCell(
            Row(
              children: [
                IconButton(
                    tooltip: 'Acessar ingrediente',
                    onPressed: () => Navigator.pushNamed(context, '/products/${ingredient.id}', arguments: ingredient.component?.name ?? ''),
                    icon: Icon(Icons.navigate_next)),
                IconButton(tooltip: 'Editar ingrediente', onPressed: onEdit, icon: Icon(Icons.edit)),
                IconButton(tooltip: 'Excluir ingrediente', onPressed: onDelete, icon: Icon(Icons.delete))
              ],
            ),
          ),
        ]);
}
