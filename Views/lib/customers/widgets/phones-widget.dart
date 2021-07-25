import 'package:comies/components.dart';
import 'package:comies/core.dart';
import 'package:flutter/material.dart';

class PhonesWidget extends StatefulWidget {
  final List<Phone>? phones;
  final Phone? model;
  final VoidCallback? onSave;
  final VoidCallback? onDelete;

  const PhonesWidget({Key? key, this.phones, this.onSave, this.onDelete, this.model}) : super(key: key);

  @override
  _PhonesWidgetState createState() => _PhonesWidgetState();
}

class _PhonesWidgetState extends State<PhonesWidget> {
  int? editIndex;

  List<DataCell> insertItem(BuildContext context, int? index, Phone? ent) {
    ent = ent ?? widget.model;
    return [
      DataCell(TextFormField(onChanged: (s) => ent?.ddd = s)),
      DataCell(TextFormField(onChanged: (s) => ent?.number = s)),
    ];
  }

  List<DataCell> getTemplate(BuildContext context, int index, Phone ent) {
    return <DataCell>[
      DataCell(Text(getTextView(ent.ddd))),
      DataCell(Text(getTextView(ent.number))),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return DataTableEditor<Phone>(
      source: widget.phones ?? <Phone>[],
      columns: ['DDD', 'Número'],
      insertTemplate: insertItem,
      itemTemplate: getTemplate,
      hasActions: true,
      hasAddition: true,
      hasDeletion: true,
      hasEdition: true,
      onSaveAction: widget.onSave,
      onDeleteAction: widget.onDelete,
      onCancelAction: (f){editIndex = null; f.currentState?.reset();},
    );
  }
}
