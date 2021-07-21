import 'package:comies/core.dart';

abstract class StoreOwnedEntity extends Entity {
  String? storeId;
}

abstract class Entity implements DataModel {
  String? id = guidEmpty;

  bool? active = true;

  DateTime? creationDate = DateTime.now();
}
