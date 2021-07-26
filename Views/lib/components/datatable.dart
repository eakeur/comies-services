import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class DataTableEditor<T> extends StatefulWidget {

  final List<DataCell> Function(BuildContext, int, T) itemTemplate;
  final List<DataCell> Function(BuildContext, int, T) editionTemplate;
  final List<DataCell> Function(BuildContext) insertionTemplate;

  final bool hasActions;
  final bool hasAddition;
  final bool hasEdition;
  final bool hasDeletion;

  final Function? onSaveAction;
  final Function(int)? onEditAction;
  final Function(T)? onDeleteAction;
  final Function(GlobalKey<FormState>)? onCancelAction;

  final List<String> columns;

  final List<T> source;

  final int editIndex;

  const DataTableEditor({
    Key? key,
    required this.itemTemplate,
    required this.editionTemplate,
    required this.insertionTemplate,
    required this.source,
    required this.columns,
    required this.editIndex,
    
    this.onSaveAction,
    this.onEditAction,
    this.onDeleteAction,
    this.onCancelAction,

    this.hasActions = false,
    this.hasAddition = false,
    this.hasEdition = false,
    this.hasDeletion = false,

  }) : super(key: key);

  @override
  _DataTableEditorState<T> createState() => _DataTableEditorState<T>();
}

class _DataTableEditorState<T> extends State<DataTableEditor<T>> {

  final GlobalKey<FormState> formState = GlobalKey<FormState>();


  List<DataColumn> getColumns() {
    return <DataColumn>[
      ...widget.columns.map((e) => DataColumn(label: Text(e), tooltip: e)).toList(),
      if (widget.hasActions) DataColumn(label: Text('Ações'), tooltip: 'Ações'),
    ];
  }

  List<DataRow> getRows() {
    return <DataRow>[
      ...widget.source.map((e) => DataRow(cells: getCells(e))).toList(),
      if (widget.hasActions) DataRow(cells: getInsert()),
    ];
  }

  DataCell getEditionActions(bool isEdition, T e){
    return DataCell(
      Row(
        children: !isEdition
          ? [
              if (widget.hasEdition) IconButton(onPressed: () => widget.onEditAction!(widget.source.indexOf(e)), icon: Icon(Icons.edit)),
              if (widget.hasDeletion) IconButton(onPressed: () => widget.onDeleteAction!(e), icon: Icon(Icons.delete)),
            ] : [
              if (widget.hasAddition) IconButton(onPressed: () => widget.onSaveAction!(), icon: Icon(Icons.save)),
              if (widget.hasAddition) IconButton(onPressed: () => widget.onCancelAction!(formState), icon: Icon(Icons.cancel)),
            ],
          ),
        );
  }

  List<DataCell> getCells(T e) {
    var isEdition = widget.source.indexOf(e) == widget.editIndex;
    return <DataCell>[
      if (isEdition) ...widget.editionTemplate(context, widget.editIndex, e) else ...widget.itemTemplate(context, widget.source.indexOf(e), e),
      if (widget.hasActions) getEditionActions(isEdition, e),
    ];
  }

  List<DataCell> getInsert() {
    return <DataCell>[
      ...widget.insertionTemplate(context),
      if (widget.hasActions)
        DataCell(
          Row(
            children: [
              if (widget.hasAddition) IconButton(onPressed: () => widget.onSaveAction!(), icon: Icon(Icons.save)),
              if (widget.hasAddition) IconButton(onPressed: () => widget.onCancelAction!(formState), icon: Icon(Icons.cancel)),
            ],
          ),
        )
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formState,
      child: DataTable(
        columns: getColumns(),
        rows: getRows(),
      ),
    );
  }
}
