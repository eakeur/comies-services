import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class DataTableEditor<T> extends StatefulWidget {
  final List<DataCell> Function(BuildContext, int, T) itemTemplate;
  final List<DataCell> Function(BuildContext, int?, T?) insertTemplate;
  final bool hasActions;
  final bool hasAddition;
  final bool hasEdition;
  final bool hasDeletion;
  final Function? onSaveAction;
  final Function? onEditAction;
  final Function? onDeleteAction;
  final Function(GlobalKey<FormState>)? onCancelAction;
  final List<String> columns;
  final List<T> source;
  final int? editIndex;

  const DataTableEditor({
    Key? key,
    required this.itemTemplate,
    required this.insertTemplate,
    required this.source,
    required this.columns,
    this.editIndex,
    this.hasActions = false,
    this.onSaveAction,
    this.onEditAction,
    this.onDeleteAction,
    this.onCancelAction,
    this.hasAddition = false,
    this.hasEdition = false,
    this.hasDeletion = false,
  }) : super(key: key);

  @override
  _DataTableEditorState<T> createState() => _DataTableEditorState<T>();
}

class _DataTableEditorState<T> extends State<DataTableEditor<T>> {
  late ValueNotifier<int?> notif;
  late GlobalKey<FormState> formState;

  @override
  void initState() {
    notif = ValueNotifier(widget.editIndex);
    formState = GlobalKey<FormState>();
    super.initState();
  }

  @override
  void didUpdateWidget(covariant DataTableEditor<T> oldWidget) {
    notif = ValueNotifier(widget.editIndex);
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    notif.dispose();
    super.dispose();
  }

  List<DataColumn> getColumns() {
    return <DataColumn>[
      ...widget.columns.map((e) => DataColumn(label: Text(e), tooltip: e)).toList(),
      if (widget.hasActions) DataColumn(label: Text('Ações'), tooltip: 'Ações'),
    ];
  }

  List<DataRow> getRows() {
    return <DataRow>[

      if (widget.hasAddition) DataRow(cells: widget.insertTemplate(context, null, null)),
    ];
  }

  List<DataCell> getCells(T e) {
    
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int?>(
      valueListenable: notif,
      builder: (context, val, child) => Form(
        key: formState,
        child: DataTable(
          columns: getColumns(),
          rows: [
            ...widget.source.map((e) {
              List<DataCell> cells = [];
              if (val != null && widget.source.indexOf(e) == val) {
                cells = widget.insertTemplate(context, val, e);
                if (widget.hasActions)
                  cells.add(
                    DataCell(
                      Row(
                        children: [
                          if (widget.hasAddition) IconButton(onPressed: () => widget.onSaveAction!(), icon: Icon(Icons.save)),
                          if (widget.hasDeletion) IconButton(onPressed: () => widget.onCancelAction!(formState), icon: Icon(Icons.cancel)),
                        ],
                      ),
                    ),
                  );
              } else {
                cells = widget.itemTemplate(context, widget.source.indexOf(e), e);
                if (widget.hasActions)
                  cells.add(
                    DataCell(
                      Row(
                        children: [
                          if (widget.hasEdition) IconButton(onPressed: () => widget.onEditAction!(e), icon: Icon(Icons.edit)),
                          if (widget.hasDeletion) IconButton(onPressed: () => widget.onDeleteAction!(e), icon: Icon(Icons.delete)),
                        ],
                      ),
                    ),
                  );
              }
              return DataRow(cells: cells);
            }),
            DataRow(cells: widget.insertTemplate(context, null, null)),
          ],
        ),
      ),
    );
  }
}
