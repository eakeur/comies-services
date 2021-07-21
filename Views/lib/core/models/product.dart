import 'dart:convert';

import 'package:comies/core.dart';

class Product implements StoreOwnedEntity {
  String? categoryId;
  String? stockId;
  String? tags;
  String? code;
  String? name;
  String? display;
  String? description;

  double? minimum;
  double? discount;
  double? price;
  double? value;

  int? type;

  int? sellUnity;

  @override
  bool? active;

  @override
  DateTime? creationDate;

  @override
  String? id;

  @override
  String? storeId;

  Product({
    this.categoryId,
    this.stockId,
    this.tags,
    this.code,
    this.name,
    this.display,
    this.description,
    this.minimum,
    this.discount,
    this.price,
    this.value,
    this.type,
    this.sellUnity,
    this.active,
    this.creationDate,
    this.id,
    this.storeId,
  });

  Product copyWith({
    String? categoryId,
    String? stockId,
    String? tags,
    String? code,
    String? name,
    String? display,
    String? description,
    double? minimum,
    double? discount,
    double? price,
    double? value,
    int? type,
    int? sellUnity,
    bool? active,
    DateTime? creationDate,
    String? id,
    String? storeId,
  }) {
    return Product(
      categoryId: categoryId ?? this.categoryId,
      stockId: stockId ?? this.stockId,
      tags: tags ?? this.tags,
      code: code ?? this.code,
      name: name ?? this.name,
      display: display ?? this.display,
      description: description ?? this.description,
      minimum: minimum ?? this.minimum,
      discount: discount ?? this.discount,
      price: price ?? this.price,
      value: value ?? this.value,
      type: type ?? this.type,
      sellUnity: sellUnity ?? this.sellUnity,
      active: active ?? this.active,
      creationDate: creationDate ?? this.creationDate,
      id: id ?? this.id,
      storeId: storeId ?? this.storeId,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'categoryId': categoryId,
      'stockId': stockId,
      'tags': tags,
      'code': code,
      'name': name,
      'display': display,
      'description': description,
      'minimum': minimum ?? 0,
      'discount': discount ?? 0,
      'price': price ?? 0,
      'value': value ?? 0,
      'type': type ?? 0,
      'sellUnity': sellUnity ?? 0,
      'active': active ?? false,
      'creationDate': creationDate?.toIso8601String(),
      'id': id,
      'storeId': storeId,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      categoryId: map['categoryId'],
      stockId: map['stockId'],
      tags: map['tags'],
      code: map['code'],
      name: map['name'],
      display: map['display'],
      description: map['description'],
      minimum: map['minimum'] * 1.00,
      discount: map['discount'] * 1.00,
      price: map['price'] * 1.00,
      value: map['value'] * 1.00,
      type: map['type'],
      sellUnity: map['sellUnity'],
      active: map['active'],
      creationDate: DateTime.parse(map['creationDate']),
      id: map['id'],
      storeId: map['storeId'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Product.fromJson(String source) => Product.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Product(categoryId: $categoryId, stockId: $stockId, tags: $tags, code: $code, name: $name, display: $display, description: $description, minimum: $minimum, discount: $discount, price: $price, value: $value, type: $type, sellUnity: $sellUnity, active: $active, creationDate: $creationDate, id: $id, storeId: $storeId)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Product &&
        other.categoryId == categoryId &&
        other.stockId == stockId &&
        other.tags == tags &&
        other.code == code &&
        other.name == name &&
        other.display == display &&
        other.description == description &&
        other.minimum == minimum &&
        other.discount == discount &&
        other.price == price &&
        other.value == value &&
        other.type == type &&
        other.sellUnity == sellUnity &&
        other.active == active &&
        other.creationDate == creationDate &&
        other.id == id &&
        other.storeId == storeId;
  }

  @override
  int get hashCode {
    return categoryId.hashCode ^
        stockId.hashCode ^
        tags.hashCode ^
        code.hashCode ^
        name.hashCode ^
        display.hashCode ^
        description.hashCode ^
        minimum.hashCode ^
        discount.hashCode ^
        price.hashCode ^
        value.hashCode ^
        type.hashCode ^
        sellUnity.hashCode ^
        active.hashCode ^
        creationDate.hashCode ^
        id.hashCode ^
        storeId.hashCode;
  }
}
