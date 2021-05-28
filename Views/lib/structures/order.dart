import 'package:comies/structures/structures.dart';
class Order {
  int id;
  DateTime placed;
  Status status;
  DeliverType deliverType;
  PaymentMethod payment;
  Store store;
  Costumer costumer;
  Operator operator;
  List<Item> items;
  String observations;
  Address address;
  double price;
  bool active;
}
