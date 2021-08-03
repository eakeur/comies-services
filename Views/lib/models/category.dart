import 'dart:convert';

import 'package:comies/core.dart';

class Category implements StoreOwnedEntity {
  String? code;
  String? name;
  String? color;
  String? description;

  @override
  bool? active;

  @override
  DateTime? creationDate;

  @override
  String? id;

  @override
  String? storeId;
  Category({
    this.code,
    this.name,
    this.color = '',
    this.description,
    this.active = true,
    this.creationDate,
    this.id = guidEmpty,
    this.storeId = guidEmpty,
  });

  Category copyWith({
    String? code,
    String? name,
    String? color,
    String? description,
    bool? active,
    DateTime? creationDate,
    String? id,
    String? storeId,
  }) {
    return Category(
      code: code ?? this.code,
      name: name ?? this.name,
      color: color ?? this.color,
      description: description ?? this.description,
      active: active ?? this.active,
      creationDate: creationDate ?? this.creationDate,
      id: id ?? this.id,
      storeId: storeId ?? this.storeId,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'code': code,
      'name': name,
      'color': color,
      'description': description,
      'active': active,
      'creationDate': creationDate?.toIso8601String(),
      'id': id,
      'storeId': storeId,
    };
  }

  Category fromMap(Map<String, dynamic> map) => Category.fromMap(map);

  factory Category.fromMap(Map<String, dynamic> map) {
    return Category(
      code: map['code'],
      name: map['name'],
      color: map['color'],
      description: map['description'],
      active: map['active'],
      creationDate: DateTime.parse(map['creationDate']),
      id: map['id'],
      storeId: map['storeId'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Category.fromJson(String source) => Category.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Category(code: $code, name: $name, color: $color, description: $description, active: $active, creationDate: $creationDate, id: $id, storeId: $storeId)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Category &&
        other.code == code &&
        other.name == name &&
        other.color == color &&
        other.description == description &&
        other.active == active &&
        other.creationDate == creationDate &&
        other.id == id &&
        other.storeId == storeId;
  }

  @override
  int get hashCode {
    return code.hashCode ^ name.hashCode ^ color.hashCode ^ description.hashCode ^ active.hashCode ^ creationDate.hashCode ^ id.hashCode ^ storeId.hashCode;
  }
}
