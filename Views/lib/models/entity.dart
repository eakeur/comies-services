import 'package:comies/core.dart';
import 'package:datacontext/datacontext.dart';

abstract class StoreOwnedEntity extends Entity {
  String? storeId;
}

abstract class Entity implements DataClass {
  String? id = guidEmpty;

  bool? active = true;

  DateTime? creationDate = DateTime.now();
}
