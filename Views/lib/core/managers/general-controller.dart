import 'package:comies/core.dart';
import 'package:flutter/material.dart';

abstract class GeneralController<Model extends Entity, View extends DataModel, FilterType extends Filter> extends ChangeNotifier {
  late BuildContext context;

  late Service service;

  late ValueNotifier<LoadStatus> listStatus;

  late ValueNotifier<LoadStatus> status;

  late bool navigate;

  abstract FilterType filter;

  late String route;

  abstract Model Function(Map<String, dynamic>) modelParser;

  abstract Model Function() newModelParser;

  abstract View Function(Map<String, dynamic>) viewParser;

  List<View> list = <View>[];

  int totalRecords = 0;

  Model? model;

  GeneralController(this.context, this.route) {
    service = getProvider(context).service;
    listStatus = ValueNotifier<LoadStatus>(LoadStatus.LOADED);
    status = ValueNotifier<LoadStatus>(LoadStatus.LOADED);
  }

  void _setSkipValue() {
    filter.skip = recordsToSkip;
  }

  Future<List<View>> loadMany({String? localRoute, bool overwrite = false}) async {
    ServerResponse res;
    try {
      listStatus.value = LoadStatus.LOADING;
      _setSkipValue();
      res = await service.getMany(filter: filter, route: localRoute ?? route);
      totalRecords = res.records ?? 0;
      if (overwrite) list = (res.data as List).map((x) => viewParser(x as Map<String, dynamic>)).toList();
      list.addAll((res.data as List).map((x) => viewParser(x as Map<String, dynamic>)));
      listStatus.value = LoadStatus.LOADED;
      return list;
    } catch (e) {
      print(e);
      listStatus.value = LoadStatus.FAILED;
      return list;
    }
  }

  Future<Model?> loadOne(String? id) async {
    try {
      if (id != null) {
        if (id == 'new') {
          model = newModelParser();
        } else if (id == "copy") {
        } else {
          status.value = LoadStatus.LOADING;
          var res = await service.getOne(uniqueID: id, route: route);
          if (!res.success)
            showFeedback(context, title: res.message ?? '', success: res.success);
          else
            model = modelParser(res.data as Map<String, dynamic>);
        }
      }
      status.value = LoadStatus.LOADED;
      return model;
    } catch (e) {
      print(e);
      status.value = LoadStatus.FAILED;
      return model;
    }
  }

  Future<Model?> save() async {
    try {
      if (model != null) {
        status.value = LoadStatus.LOADING;
        ServerResponse res;
        if (model!.id == null || model!.id == guidEmpty) {
          res = await service.addOne<Model>(model!, route: route);
          status.value = res.success ? LoadStatus.LOADED : LoadStatus.FAILED;
        } else {
          res = await service.put<Model>(model!, route: route, uniqueID: model!.id!);
          status.value = res.success ? LoadStatus.LOADED : LoadStatus.FAILED;
        }
        showFeedback(context, title: res.message ?? '', success: res.success);
      }
    } catch (e) {}
    status.value = LoadStatus.LOADED;
  }

  Future<void> delete() async {
    try {
      if (model != null) {
        status.value = LoadStatus.LOADING;
        ServerResponse res;
        if (model!.id != null) {
          res = await service.del(route: route, uniqueID: model!.id!);
          status.value = res.success ? LoadStatus.LOADED : LoadStatus.FAILED;
          showFeedback(context, title: res.message ?? '', success: res.success);
          if (navigate) Navigator.of(context).pop();
        }
      }
    } catch (e) {}
    status.value = LoadStatus.LOADED;
  }

  void copyProduct() {}

  int get recordsToSkip => totalRecords - list.length;

  bool get fetchedAll => list.length == totalRecords;
}
