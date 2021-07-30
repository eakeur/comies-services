import 'package:comies/core.dart';
import 'package:datacontext/datacontext.dart';
import 'package:flutter/material.dart';

class PhonesForm extends StatefulWidget {

  final void Function(Phone) onSave;

  final void Function(Phone) onDelete;

  const PhonesForm({
    Key? key,
    required this.data,
    required this.onSave,
    required this.onDelete,
  }) : super(key: key);

  @override
  _PhonesFormState createState() => _PhonesFormState();
}

class _PhonesFormState extends State<PhonesForm> {

  final GlobalKey<FormState> formState = GlobalKey<FormState>();

  int editIndex = -1;
  
  Phone? editionBackup;


  void onEdit(Phone p){
    formState.currentState?.reset();
    setState(() {
      editIndex = widget.data.list.indexOf(p);
      editionBackup = widget.data.list[editIndex];
      widget.data.setModel(widget.data.list[editIndex]);
    });
  }

  void onCancel(){
    formState.currentState?.reset();
    setState(() {
      editIndex = - 1;
      if (isEdition) widget.data.list[editIndex] = editionBackup!;
      widget.data.clearModel();
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
              ...widget.data.list.map((p){
                return editIndex != widget.data.list.indexOf(p)
                  ? DataExibitionRow(phone: p, onEdit: () => onEdit(p), onDelete: () => widget.onDelete(p))
                  : DataEditionRow(phone: p, onSave: () => widget.onSave(p), onCancel: onCancel);
              }).toList(),
              DataEditionRow(
                phone: widget.data.model!, 
                onSave: () => widget.onSave(widget.data.model!), 
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
        children: [
          IconButton(onPressed: onEdit, icon: Icon(Icons.edit)),
          IconButton(onPressed: onDelete, icon: Icon(Icons.delete))
        ],
      ),
    ),
  ]);
}

