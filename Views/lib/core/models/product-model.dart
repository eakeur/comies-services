import 'dart:convert';

import 'package:comies/core.dart';

class Product extends DataModel {
  final String storeId;
  final bool active;
  final String creationDate;
  final String id;
  final String code;
  final String name;
  final String display;
  final String description;
  final int sellUnity;
  final double minimum;
  final String? categoryId;
  final String? stockId;
  final String tags;
  final double discount;
  final double price;
  final double value;
  final int type;
  
  Product({
    required this.storeId,
    required this.active,
    required this.creationDate,
    required this.id,
    required this.code,
    required this.name,
    required this.display,
    required this.description,
    required this.sellUnity,
    required this.minimum,
     this.categoryId,
     this.stockId,
    required this.tags,
    required this.discount,
    required this.price,
    required this.value,
    required this.type,
  });

  Product copyWith({
    String? storeId,
    bool? active,
    String? creationDate,
    String? id,
    String? code,
    String? name,
    String? display,
    String? description,
    int? sellUnity,
    double? minimum,
    String? categoryId,
    String? stockId,
    String? tags,
    double? discount,
    double? price,
    double? value,
    int? type,
  }) {
    return Product(
      storeId: storeId ?? this.storeId,
      active: active ?? this.active,
      creationDate: creationDate ?? this.creationDate,
      id: id ?? this.id,
      code: code ?? this.code,
      name: name ?? this.name,
      display: display ?? this.display,
      description: description ?? this.description,
      sellUnity: sellUnity ?? this.sellUnity,
      minimum: minimum ?? this.minimum,
      categoryId: categoryId ?? this.categoryId,
      stockId: stockId ?? this.stockId,
      tags: tags ?? this.tags,
      discount: discount ?? this.discount,
      price: price ?? this.price,
      value: value ?? this.value,
      type: type ?? this.type,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'storeId': storeId,
      'active': active,
      'creationDate': creationDate,
      'id': id,
      'code': code,
      'name': name,
      'display': display,
      'description': description,
      'sellUnity': sellUnity,
      'minimum': minimum,
      'categoryId': categoryId,
      'stockId': stockId,
      'tags': tags,
      'discount': discount,
      'price': price,
      'value': value,
      'type': type,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      storeId: map['storeId'],
      active: map['active'],
      creationDate: map['creationDate'],
      id: map['id'],
      code: map['code'],
      name: map['name'],
      display: map['display'],
      description: map['description'],
      sellUnity: map['sellUnity'],
      minimum: map['minimum'],
      categoryId: map['categoryId'],
      stockId: map['stockId'],
      tags: map['tags'],
      discount: map['discount'],
      price: map['price'],
      value: map['value'],
      type: map['type'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Product.fromJson(String source) => Product.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Product(storeId: $storeId, active: $active, creationDate: $creationDate, id: $id, code: $code, name: $name, display: $display, description: $description, sellUnity: $sellUnity, minimum: $minimum, categoryId: $categoryId, stockId: $stockId, tags: $tags, discount: $discount, price: $price, value: $value, type: $type)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is Product &&
      other.storeId == storeId &&
      other.active == active &&
      other.creationDate == creationDate &&
      other.id == id &&
      other.code == code &&
      other.name == name &&
      other.display == display &&
      other.description == description &&
      other.sellUnity == sellUnity &&
      other.minimum == minimum &&
      other.categoryId == categoryId &&
      other.stockId == stockId &&
      other.tags == tags &&
      other.discount == discount &&
      other.price == price &&
      other.value == value &&
      other.type == type;
  }

  @override
  int get hashCode {
    return storeId.hashCode ^
      active.hashCode ^
      creationDate.hashCode ^
      id.hashCode ^
      code.hashCode ^
      name.hashCode ^
      display.hashCode ^
      description.hashCode ^
      sellUnity.hashCode ^
      minimum.hashCode ^
      categoryId.hashCode ^
      stockId.hashCode ^
      tags.hashCode ^
      discount.hashCode ^
      price.hashCode ^
      value.hashCode ^
      type.hashCode;
  }
}
