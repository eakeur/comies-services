import 'package:comies/components.dart';
import 'package:comies/components/layouts/general-list.dart';
import 'package:comies/core.dart';
import 'package:flutter/material.dart';

class GeneralScreen<Model extends Entity, View extends DataModel, FilterType extends Filter> extends StatefulWidget {
  final GeneralController<Model, View, FilterType> Function(BuildContext) controllerBuilder;

  final PreferredSizeWidget? appBar;

  // List parameters
  final void Function(View) onListTap;

  final String Function(View)? listTileTitleGetter;

  final String Function(View)? listTileSubtitileGetter;

  final String? pageTitle;

  final List<Widget>? children;

  final void Function(BuildContext)? onAddClick;

  const GeneralScreen({Key? key, required this.controllerBuilder, this.onAddClick, this.appBar, this.pageTitle, required this.onListTap, this.children, this.listTileTitleGetter, this.listTileSubtitileGetter}) : super(key: key);

  @override
  _GeneralScreenState<Model, View, FilterType> createState() => _GeneralScreenState<Model, View, FilterType>();
}

class _GeneralScreenState<Model extends Entity, View extends DataModel, FilterType extends Filter> extends State<GeneralScreen<Model, View, FilterType>> {
  late GeneralController<Model, View, FilterType> controller;

  @override
  void initState() {
    controller = widget.controllerBuilder(context);
    controller.loadMany();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: FloatingActionButton(tooltip: 'Adicionar produto', child: Icon(Icons.add), onPressed: () => widget.onAddClick!(context)),
      appBar: widget.appBar ?? AppBar(title: Text(widget.pageTitle!, style: getPageTitle())),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: isWidthSmall(context) ? 0 : 20),
        child: ResponsiveWidget(
          flexes: [30, 70],
          children: [
            ValueListenableBuilder<LoadStatus>(
              valueListenable: controller.listStatus,
              builder: (context, status, child) {
                if (status == LoadStatus.LOADED)
                  return Card(
                      child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: GeneralList<View>(
                            modelList: controller.list,
                            onTap: widget.onListTap,
                            titleGetter: widget.listTileTitleGetter,
                            subtitleGetter: widget.listTileSubtitileGetter,
                          )));
                return Container();
              },
            ),
            Container(),
            if (widget.children != null) ...widget.children!
          ],
        ),
      ),
    );
  }
}
