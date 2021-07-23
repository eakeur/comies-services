import 'package:comies/core.dart';
import 'package:flutter/material.dart';
import 'models.dart';

class CustomerController extends GeneralController<Customer, CustomerView, CustomerFilter> {
  CustomerController(BuildContext context) : super(context, '/customers');

  @override
  CustomerFilter filter = CustomerFilter();

  @override
  Customer Function(Map<String, dynamic> map) modelParser = (map) => Customer.fromMap(map);

  @override
  Customer Function() newModelParser = () => Customer(creationDate: DateTime.now(), memberSince: DateTime.now());

  @override
  CustomerView Function(Map<String, dynamic> map) viewParser = (map) => CustomerView.fromMap(map);
}
