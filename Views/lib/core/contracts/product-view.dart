import 'dart:convert';

import 'package:comies/core.dart';

class ProductView implements DataModel {
  final String id;
  final String code;
  final String name;
  final double value;
  final String? categotyId;
  final int? stockLevel;
  final String? categoryName;
  ProductView({
    required this.id,
    required this.code,
    required this.name,
    required this.value,
    this.categotyId,
    this.stockLevel,
    this.categoryName,
  });

  ProductView copyWith({
    String? id,
    String? code,
    String? name,
    double? value,
    String? categotyId,
    int? stockLevel,
    String? categoryName,
  }) {
    return ProductView(
      id: id ?? this.id,
      code: code ?? this.code,
      name: name ?? this.name,
      value: value ?? this.value,
      categotyId: categotyId ?? this.categotyId,
      stockLevel: stockLevel ?? this.stockLevel,
      categoryName: categoryName ?? this.categoryName,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'code': code,
      'name': name,
      'value': value,
      'categotyId': categotyId,
      'stockLevel': stockLevel,
      'categoryName': categoryName,
    };
  }

  factory ProductView.fromMap(Map<String, dynamic> map) {
    return ProductView(
      id: map['id'],
      code: map['code'],
      name: map['name'],
      value: map['value'],
      categotyId: map['categotyId'],
      stockLevel: map['stockLevel'],
      categoryName: map['categoryName'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductView.fromJson(String source) => ProductView.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ProductView(id: $id, code: $code, name: $name, value: $value, categotyId: $categotyId, stockLevel: $stockLevel, categoryName: $categoryName)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is ProductView &&
      other.id == id &&
      other.code == code &&
      other.name == name &&
      other.value == value &&
      other.categotyId == categotyId &&
      other.stockLevel == stockLevel &&
      other.categoryName == categoryName;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      code.hashCode ^
      name.hashCode ^
      value.hashCode ^
      categotyId.hashCode ^
      stockLevel.hashCode ^
      categoryName.hashCode;
  }
}
