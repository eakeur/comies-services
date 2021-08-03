import 'package:comies/core.dart';
import 'package:flutter/material.dart';

class PhonesForm extends StatefulWidget {
  final void Function(Phone) onSave;

  final void Function(Phone) onDelete;

  final void Function(Phone) onEdit;

  final void Function() onCancel;

  final Phone data;

  final List<Phone> phones;

  const PhonesForm({
    Key? key,
    required this.data,
    required this.phones,
    required this.onSave,
    required this.onDelete,
    required this.onEdit,
    required this.onCancel,
  }) : super(key: key);

  @override
  _PhonesFormState createState() => _PhonesFormState();
}

class _PhonesFormState extends State<PhonesForm> {
  final GlobalKey<FormState> formState = GlobalKey<FormState>();

  int editIndex = -1;

  Phone? editionBackup;

  void onEdit(Phone p) {
    formState.currentState?.reset();
    widget.onEdit(p);
    setState(() {
      editIndex = widget.phones.indexOf(p);
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
          Text('Telefones', style: getSubtitleText(size: 16)),
          DataTable(
            columns: ['DDD', 'Número', 'Ações'].map((c) => DataColumn(label: Text(c), tooltip: c)).toList(),
            rows: [
              ...widget.phones.map((p) {
                return editIndex != widget.phones.indexOf(p)
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
    required Phone phone,
    required VoidCallback onSave,
    required VoidCallback onCancel,
  }) : super(cells: <DataCell>[
          DataCell(TextFormField(
            onChanged: (s) => phone.ddd = s,
            initialValue: phone.ddd,
          )),
          DataCell(TextFormField(
            onChanged: (s) => phone.number = s,
            initialValue: phone.number,
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
    required Phone phone,
    required VoidCallback onEdit,
    required VoidCallback onDelete,
  }) : super(cells: <DataCell>[
          DataCell(Text(getTextView(phone.ddd))),
          DataCell(Text(getTextView(phone.number))),
          DataCell(
            Row(
              children: [IconButton(onPressed: onEdit, icon: Icon(Icons.edit)), IconButton(onPressed: onDelete, icon: Icon(Icons.delete))],
            ),
          ),
        ]);
}
