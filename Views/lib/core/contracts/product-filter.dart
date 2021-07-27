import 'dart:convert';

import 'package:comies/core.dart';

class ProductFilter implements DataModel, Filter {
  int? skip;
  final String? categoryId;
  final String? code;
  final String? name;
  final String? tag;
  ProductFilter({
    this.skip = 0,
    this.categoryId,
    this.code,
    this.name,
    this.tag,
  });

  ProductFilter copyWith({
    int? skip,
    String? categoryId,
    String? code,
    String? name,
    String? tag,
  }) {
    return ProductFilter(
      skip: skip ?? this.skip,
      categoryId: categoryId ?? this.categoryId,
      code: code ?? this.code,
      name: name ?? this.name,
      tag: tag ?? this.tag,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'skip': skip,
      'categoryId': categoryId,
      'code': code,
      'name': name,
      'tag': tag,
    };
  }

  factory ProductFilter.fromMap(Map<String, dynamic> map) {
    return ProductFilter(
      skip: map['skip'],
      categoryId: map['categoryId'],
      code: map['code'],
      name: map['name'],
      tag: map['tag'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductFilter.fromJson(String source) => ProductFilter.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ProductFilter(skip: $skip, categoryId: $categoryId, code: $code, name: $name, tag: $tag)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ProductFilter && other.skip == skip && other.categoryId == categoryId && other.code == code && other.name == name && other.tag == tag;
  }

  @override
  int get hashCode {
    return skip.hashCode ^ categoryId.hashCode ^ code.hashCode ^ name.hashCode ^ tag.hashCode;
  }
}
