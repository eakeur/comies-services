import 'dart:collection';
import 'dart:convert';
import 'package:comies/main.dart';
import 'package:comies/services/general.service.dart';
import 'package:comies/utils/converters.dart';
import 'package:comies/structures/structures.dart';
import 'package:flutter/foundation.dart';
// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as HTML show WebSocket, document;
import 'package:flutter/widgets.dart';

class KitchenController extends ChangeNotifier {

  List<Order> _orders = [];
  Order _order;
  Status _status = Status.pending;

  List<Order> get orders => _orders.where((ord) => ord.status == status).toList();
  Order get order => _order;
  Status get status => _status; set status(Status st){
    _status = st; sendToPan('filter-status', st.index);
  }
  String get statusName {
    switch(status){
      case Status.pending: return "pendente";
      case Status.preparing: return "preparando";
      default: return "";
    }
  }


  String _code = "";

  List<Order> get pending =>  _orders.where((ord) => ord.status == Status.pending).toList();
  List<Order> get preparing =>  _orders.where((ord) => ord.status == Status.preparing).toList();
  Order get selectedOrder => _order;
  bool get hasSelectedOrder => _order != null;
  String get code => _code;

  HTML.WebSocket _pan;
  HTML.WebSocket _spoon;


  LoadStatus sliderLoadStatus = LoadStatus.waitingStart;
  LoadStatus panLoadStatus = LoadStatus.waitingStart;
  LoadStatus spoonLoadStatus = LoadStatus.waitingStart;
  LoadStatus pendingLoadStatus = LoadStatus.waitingStart;
  LoadStatus preparingLoadStatus = LoadStatus.waitingStart;
  LoadStatus prepareLoadStatus = LoadStatus.waitingStart;
  LoadStatus finishLoadStatus = LoadStatus.waitingStart;

  bool prepareOrderPending = false;


  Service<Order> orderService = new Service<Order>("orders", serializeOrder, deserializeOrderMap);


  String get kitchenRoute => "${session.server.replaceFirst("http://", "ws://").replaceFirst("https://", "wss://")}/kitchen/${session.partner.id}/${session.store.id}";

  KitchenController(String type, {ScrollController controller, String panID}){
    switch (type){
      case "spoon": connectToKitchenAsSpoon(panID); break;
      case "pan": connectToKitchenAsPan(controller); break;
      default: throw Exception();
    }
  }

  void connectToKitchenAsPan(ScrollController controller) async {
    HTML.document.cookie = "authorization = ${session.token};";
      _pan = new HTML.WebSocket(kitchenRoute+"/TV");
      _pan.onMessage.listen((data) => listenToPanUpdates(data.data, controller));
  }



  void listenToPanUpdates(dynamic data, ScrollController controller){
    try {
      if (data != null){
        var decoded = jsonDecode(data);

        if (decoded['sender'] == 'server'){
          if (decoded['type'] == 'pan-initial'){
            decoded['data'].map((e) => deserializeOrderMap(e)).toList().forEach((ord) {
              if (!_orders.any((order) => order.id == ord.id)) _orders.add(ord);
            });
             _code = decoded['code'].toString();
          }
          if (decoded['type'] == 'order-update'){
            decoded['data'].map((e) => deserializeOrderMap(e)).toList().forEach((ord) {
              if (!_orders.any((order) => order.id == ord.id)) _orders.add(ord);
              else {
                _orders.removeWhere((order) => order.id == ord.id); 
                _orders.add(ord);
                }
            });
          }
        }

        if (decoded['sender'] == 'spoon'){
          switch (decoded['type']){
            case 'scroll': controller.position.jumpTo(controller.position.pixels + decoded['value']);break;
            case 'display-order': _order = _orders.firstWhere((order) => order.id == decoded['value'], orElse: () => null); break;
            case 'filter-status': _status = Status.values[decoded['value']]; break; 
          }
        }
 
        notifyListeners();
      } else throw Exception("Nothing received from server");
    } catch (e) {
      print(e);
    }
  }

  void listenToSpoonUpdates(dynamic data){
    try {
      if (data != null){
        var decoded = jsonDecode(data);

        if (decoded['sender'] == 'server'){
          if (decoded['type'] == 'spoon-initial'){
            decoded['data'].map((e) => deserializeOrderMap(e)).toList().forEach((ord) {
              if (!_orders.any((order) => order.id == ord.id)) _orders.add(ord);
            });
          }
        }
 
        notifyListeners();
      } else throw Exception("Nothing received from server");
    } catch (e) {
      print(e);
    }
  }

  void connectToKitchenAsSpoon(String panID) async {
    _code = panID;
     HTML.document.cookie = "authorization = ${session.token}";
      _spoon = new HTML.WebSocket(kitchenRoute+"/$panID");
      _spoon.onMessage.listen((data) => listenToSpoonUpdates(data));
  }

  void sendToPan(String event, dynamic value){
   _spoon.send(jsonEncode({'sender': 'spoon', 'type':event, 'code':_code, 'value':value}));
  }

    List<Order> getOrderByStatus(Status status){
    return _orders.where((order) => order.status == status).toList();
  }


  Future<Response> updateOrder(Order Function() updater) async {
    prepareOrderPending = true;
    notifyListeners();
    try {
      var res = await orderService.update(updater());
      if (!res.success) throw res;
      return res;
    } catch (e) {
      throw e;
    } finally {
      prepareOrderPending = false;
      notifyListeners();
    }
  }


  @override
  void dispose(){
    if (_pan != null) _pan.close();
      if (_spoon != null) _spoon.close();
    super.dispose();
  }
}