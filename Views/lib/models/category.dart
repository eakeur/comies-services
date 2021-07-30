import 'dart:convert';

import 'package:comies/core.dart';

class Category implements StoreOwnedEntity {
  String? code;
  String? name;
  String? color;
  String? description;
  String? parentId;

  Category({
    this.code,
    this.name,
    this.color,
    this.description,
    this.parentId,
  });

  Category copyWith({
    String? code,
    String? name,
    String? color,
    String? description,
    String? parentId,
  }) {
    return Category(
      code: code ?? this.code,
      name: name ?? this.name,
      color: color ?? this.color,
      description: description ?? this.description,
      parentId: parentId ?? this.parentId,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'code': code,
      'name': name,
      'color': color,
      'description': description,
      'parentId': parentId,
    };
  }

  Category fromMap(Map<String, dynamic> map) => Category.fromMap(map);

  factory Category.fromMap(Map<String, dynamic> map) {
    return Category(
      code: map['code'],
      name: map['name'],
      color: map['color'],
      description: map['description'],
      parentId: map['parentId'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Category.fromJson(String source) => Category.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Category(code: $code, name: $name, color: $color, description: $description, parentId: $parentId)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Category && other.code == code && other.name == name && other.color == color && other.description == description && other.parentId == parentId;
  }

  @override
  int get hashCode {
    return code.hashCode ^ name.hashCode ^ color.hashCode ^ description.hashCode ^ parentId.hashCode;
  }

  @override
  bool? active;

  @override
  DateTime? creationDate;

  @override
  String? id;

  @override
  String? storeId;
}
