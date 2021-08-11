import 'package:comies/core.dart';
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
            columns: ['Quantidade', 'Ingrediente'].map((c) => DataColumn(label: Text(c), tooltip: c)).toList(),
            rows: [
              ...widget.ingredients.map((p) {
                return editIndex != widget.ingredients.indexOf(p)
                    ? DataExibitionRow(phone: p, onEdit: () => onEdit(p), onDelete: () => widget.onDelete(p))
                    : DataEditionRow(phone: p, onSave: () => widget.onSave(p), onCancel: onCancel);
              }).toList(),
              DataEditionRow(
                phone: widget.data,
                onSave: () => widget.onSave(widget.data),
                onCancel: onCancel,
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
    required Ingredient phone,
    required VoidCallback onSave,
    required VoidCallback onCancel,
  }) : super(cells: <DataCell>[
          DataCell(TextFormField(
            onChanged: (s) => phone.quantity = getDoubleValue(s),
            initialValue: getDoubleView(phone.quantity, 2),
          )),
          DataCell(TextFormField(
            onChanged: (s) => phone.ingredientId = s,
            initialValue: phone.ingredientId,
          )),
          DataCell(
            Row(
              children: [
                IconButton(onPressed: () => onSave, icon: Icon(Icons.save)),
                IconButton(onPressed: () => onCancel, icon: Icon(Icons.cancel)),
              ],
            ),
          )
        ]);
}

class DataExibitionRow extends DataRow {
  DataExibitionRow({
    required Ingredient phone,
    required VoidCallback onEdit,
    required VoidCallback onDelete,
  }) : super(cells: <DataCell>[
          DataCell(Text(getDoubleView(phone.quantity, 2))),
          DataCell(Text(getTextView(phone.ingredientId))),
          DataCell(
            Row(
              children: [IconButton(onPressed: onEdit, icon: Icon(Icons.edit)), IconButton(onPressed: onDelete, icon: Icon(Icons.delete))],
            ),
          ),
        ]);
}
