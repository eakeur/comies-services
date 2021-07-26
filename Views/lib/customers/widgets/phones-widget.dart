import 'package:comies/components.dart';
import 'package:comies/core.dart';
import 'package:comies/customers/controller.dart';
import 'package:flutter/material.dart';

class PhonesWidget extends StatefulWidget {
  final CustomerPhonesController controller;

  const PhonesWidget({Key? key, required this.controller}) : super(key: key);

  @override
  _PhonesWidgetState createState() => _PhonesWidgetState();
}

class _PhonesWidgetState extends State<PhonesWidget> {
  int editIndex = -1;

  CustomerPhonesController get controller => widget.controller;

  List<DataCell> editItem(BuildContext context, int index, Phone ent) {
    return [
      DataCell(TextFormField(
        onChanged: (s) => ent.ddd = s,
        initialValue: ent.ddd,
      )),
      DataCell(TextFormField(
        onChanged: (s) => ent.number = s,
        initialValue: ent.number,
      )),
    ];
  }

  List<DataCell> insertItem(BuildContext context) {
    var ent = controller.model;
    return [
      DataCell(TextFormField(
        onChanged: (s) => ent?.ddd = s,
        initialValue: ent?.ddd,
      )),
      DataCell(TextFormField(
        onChanged: (s) => ent?.number = s,
        initialValue: ent?.number,
      )),
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
    return Container(
      child: Column(
        children: [
          Text('Telefones', style: getSubtitleText(size: 16)),
          DataTableEditor<Phone>(
            source: controller.list,
            columns: ['DDD', 'Número'],
            editionTemplate: editItem,
            itemTemplate: getTemplate,
            insertionTemplate: insertItem,
            hasActions: true,
            hasAddition: true,
            hasDeletion: true,
            hasEdition: true,
            editIndex: editIndex,
            onSaveAction: () {
              widget.controller.save();
              widget.controller.list.clear();
              widget.controller.loadMany();
            },
            onDeleteAction: (m) {
              widget.controller.model = m;
              widget.controller.delete();
              widget.controller.list.clear();
              widget.controller.loadMany();
            },
            onEditAction: (e) => setState(() {
              widget.controller.model = widget.controller.list[e];
              editIndex = e;
            }),
            onCancelAction: (f) {
              setState(() => editIndex = -1);
              f.currentState?.reset();
            },
          )
        ],
      ),
    );
  }
}
