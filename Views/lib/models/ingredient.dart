import 'dart:convert';

import 'package:comies/core.dart';

class Ingredient implements StoreOwnedEntity {
  String? productId;

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
    this.productId = guidEmpty,
    this.ingredientId = guidEmpty,
    this.quantity = 0,
    this.component,
    this.active = true,
    this.creationDate,
    this.id = guidEmpty,
    this.storeId = guidEmpty,
  });

  factory Ingredient.fromJson(String source) => Ingredient.fromMap(json.decode(source));

  Ingredient copyWith({
    String? productId,
    String? ingredientId,
    double? quantity,
    Product? component,
    bool? active,
    DateTime? creationDate,
    String? id,
    String? storeId,
  }) {
    return Ingredient(
      productId: productId ?? this.productId,
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
      'productId': productId,
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
      productId: map['productId'],
      ingredientId: map['ingredientId'],
      quantity: map['quantity'] * 1.00,
      component: Product.fromMap(map['component']),
      active: map['active'],
      creationDate: DateTime.parse(map['creationDate']),
      id: map['id'],
      storeId: map['storeId'],
    );
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() {
    return 'Ingredient(productId: $productId, ingredientId: $ingredientId, quantity: $quantity, component: $component, active: $active, creationDate: $creationDate, id: $id, storeId: $storeId)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Ingredient &&
        other.productId == productId &&
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
    return productId.hashCode ^ ingredientId.hashCode ^ quantity.hashCode ^ component.hashCode ^ active.hashCode ^ creationDate.hashCode ^ id.hashCode ^ storeId.hashCode;
  }
}
