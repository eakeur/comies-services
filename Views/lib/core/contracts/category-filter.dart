import 'dart:convert';

import 'package:comies/core.dart';

class CategoryFilter implements DataModel, Filter {
  String? description;
  String? code;
  String? name;
  String? parentId;
  CategoryFilter({
    this.description,
    this.code,
    this.name,
    this.parentId,
  });

  CategoryFilter copyWith({
    String? description,
    String? code,
    String? name,
    String? parentId,
  }) {
    return CategoryFilter(
      description: description ?? this.description,
      code: code ?? this.code,
      name: name ?? this.name,
      parentId: parentId ?? this.parentId,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'description': description,
      'code': code,
      'name': name,
      'parentId': parentId,
    };
  }

  factory CategoryFilter.fromMap(Map<String, dynamic> map) {
    return CategoryFilter(
      description: map['description'],
      code: map['code'],
      name: map['name'],
      parentId: map['parentId'],
    );
  }

  String toJson() => json.encode(toMap());

  factory CategoryFilter.fromJson(String source) => CategoryFilter.fromMap(json.decode(source));

  @override
  String toString() {
    return 'CategoryFilter(description: $description, code: $code, name: $name, parentId: $parentId)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CategoryFilter && other.description == description && other.code == code && other.name == name && other.parentId == parentId;
  }

  @override
  int get hashCode {
    return description.hashCode ^ code.hashCode ^ name.hashCode ^ parentId.hashCode;
  }

  int? skip;
}
