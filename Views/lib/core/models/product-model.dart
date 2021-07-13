import 'dart:convert';

import 'package:comies/core.dart';

class Product extends DataModel {
  String? storeId;
  String? id;
  String? categoryId;
  String? stockId;

  bool? active;
  DateTime? creationDate;
  
  String? code;
  String? name;
  String? display;
  String? description;
  int? sellUnity;
  double? minimum;
  String? tags;
  double? discount;
  double? price;
  double? value;
  int? type;


  Product({
    this.storeId,
    this.id,
    this.categoryId,
    this.stockId,
    this.active,
    this.creationDate,
    this.code,
    this.name,
    this.display,
    this.description,
    this.sellUnity,
    this.minimum,
    this.tags,
    this.discount,
    this.price,
    this.value,
    this.type,
  });

  Product.empty({
    this.storeId = guidEmpty, this.active = false, 
    required this.creationDate, this.id = guidEmpty, this.code = '', this.name = '', this.display = '', this.description = '', this.sellUnity = 0, this.minimum = 0, this.categoryId, this.stockId, this.tags = '', this.discount = 0, this.price = 0, this.value = 0, this.type = 0});


  
  

  Product copyWith({
    String? storeId,
    String? id,
    String? categoryId,
    String? stockId,
    bool? active,
    DateTime? creationDate,
    String? code,
    String? name,
    String? display,
    String? description,
    int? sellUnity,
    double? minimum,
    String? tags,
    double? discount,
    double? price,
    double? value,
    int? type,
  }) {
    return Product(
      storeId: storeId ?? this.storeId,
      id: id ?? this.id,
      categoryId: categoryId ?? this.categoryId,
      stockId: stockId ?? this.stockId,
      active: active ?? this.active,
      creationDate: creationDate ?? this.creationDate,
      code: code ?? this.code,
      name: name ?? this.name,
      display: display ?? this.display,
      description: description ?? this.description,
      sellUnity: sellUnity ?? this.sellUnity,
      minimum: minimum ?? this.minimum,
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
      'id': id,
      'categoryId': categoryId,
      'stockId': stockId,
      'active': active,
      'creationDate': creationDate?.toIso8601String(),
      'code': code,
      'name': name,
      'display': display,
      'description': description,
      'sellUnity': sellUnity,
      'minimum': minimum,
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
      id: map['id'],
      categoryId: map['categoryId'],
      stockId: map['stockId'],
      active: map['active'],
      creationDate: DateTime.parse(map['creationDate']),
      code: map['code'],
      name: map['name'],
      display: map['display'],
      description: map['description'],
      sellUnity: map['sellUnity'],
      minimum: map['minimum'],
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
    return 'Product(storeId: $storeId, id: $id, categoryId: $categoryId, stockId: $stockId, active: $active, creationDate: $creationDate, code: $code, name: $name, display: $display, description: $description, sellUnity: $sellUnity, minimum: $minimum, tags: $tags, discount: $discount, price: $price, value: $value, type: $type)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is Product &&
      other.storeId == storeId &&
      other.id == id &&
      other.categoryId == categoryId &&
      other.stockId == stockId &&
      other.active == active &&
      other.creationDate == creationDate &&
      other.code == code &&
      other.name == name &&
      other.display == display &&
      other.description == description &&
      other.sellUnity == sellUnity &&
      other.minimum == minimum &&
      other.tags == tags &&
      other.discount == discount &&
      other.price == price &&
      other.value == value &&
      other.type == type;
  }

  @override
  int get hashCode {
    return storeId.hashCode ^
      id.hashCode ^
      categoryId.hashCode ^
      stockId.hashCode ^
      active.hashCode ^
      creationDate.hashCode ^
      code.hashCode ^
      name.hashCode ^
      display.hashCode ^
      description.hashCode ^
      sellUnity.hashCode ^
      minimum.hashCode ^
      tags.hashCode ^
      discount.hashCode ^
      price.hashCode ^
      value.hashCode ^
      type.hashCode;
  }
}
