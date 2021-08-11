import 'dart:convert';

import 'package:comies/core.dart';

class Ingredient implements StoreOwnedEntity {
  String? ingredientId;

  double? quantity;

  Product? component;

  @override
  bool? active;

  @override
  DateTime? creationDate;

  @override
  String? id;

  @override
  String? storeId;

  Ingredient({
    this.ingredientId = guidEmpty,
    this.quantity = 0,
    this.component,
    this.active = true,
    this.creationDate,
    this.id = guidEmpty,
    this.storeId = guidEmpty,
  });

  Ingredient copyWith({
    String? ingredientId,
    double? quantity,
    Product? component,
    bool? active,
    DateTime? creationDate,
    String? id,
    String? storeId,
  }) {
    return Ingredient(
      ingredientId: ingredientId ?? this.ingredientId,
      quantity: quantity ?? this.quantity,
      component: component ?? this.component,
      active: active ?? this.active,
      creationDate: creationDate ?? this.creationDate,
      id: id ?? this.id,
      storeId: storeId ?? this.storeId,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'ingredientId': ingredientId,
      'quantity': quantity,
      'component': component?.toMap(),
      'active': active,
      'creationDate': creationDate?.toIso8601String(),
      'id': id,
      'storeId': storeId,
    };
  }

  Ingredient fromMap(Map<String, dynamic> map) => Ingredient.fromMap(map);

  factory Ingredient.fromMap(Map<String, dynamic> map) {
    return Ingredient(
      ingredientId: map['ingredientId'],
      quantity: map['quantity'],
      component: Product.fromMap(map['component']),
      active: map['active'],
      creationDate: DateTime.parse(map['creationDate']),
      id: map['id'],
      storeId: map['storeId'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Ingredient.fromJson(String source) => Ingredient.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Ingredient(ingredientId: $ingredientId, quantity: $quantity, component: $component, active: $active, creationDate: $creationDate, id: $id, storeId: $storeId)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Ingredient &&
        other.ingredientId == ingredientId &&
        other.quantity == quantity &&
        other.component == component &&
        other.active == active &&
        other.creationDate == creationDate &&
        other.id == id &&
        other.storeId == storeId;
  }

  @override
  int get hashCode {
    return ingredientId.hashCode ^ quantity.hashCode ^ component.hashCode ^ active.hashCode ^ creationDate.hashCode ^ id.hashCode ^ storeId.hashCode;
  }
}
