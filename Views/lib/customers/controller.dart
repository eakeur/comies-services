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

  @override
  Future<Customer?> loadOne(String? id) async {
    await super.loadOne(id);
    phones = CustomerPhonesController(context, model?.id);
    await phones?.loadOne("new");
    await phones?.loadMany(overwrite: true);
    return model;
  }

  CustomerPhonesController? phones;
}

class CustomerPhonesController extends GeneralController<Phone, Phone, CustomerFilter> {
  CustomerPhonesController(BuildContext context, String? id) : super(context, '/customers/$id/phones');

  @override
  CustomerFilter filter = CustomerFilter();

  @override
  Phone Function(Map<String, dynamic> map) modelParser = (map) => Phone.fromMap(map);

  @override
  Phone Function() newModelParser = () => Phone(creationDate: DateTime.now());

  @override
  Phone Function(Map<String, dynamic> map) viewParser = (map) => Phone.fromMap(map);

  @override
  bool navigate = false;

  Future<Phone> save() async {
    var phone = await super.save();
    super.list.add(phone!);
    return phone;
  }
}
