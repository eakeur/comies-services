import 'dart:convert';

import 'package:datacontext/datacontext.dart';

class CategoryView extends DataClass {
  String? id;
  String? code;
  String? name;

  CategoryView({
    this.id,
    this.code,
    this.name,
  });

  CategoryView copyWith({
    String? id,
    String? code,
    String? name,
  }) {
    return CategoryView(
      id: id ?? this.id,
      code: code ?? this.code,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'code': code,
      'name': name,
    };
  }

  CategoryView fromMap(Map<String, dynamic> map) => CategoryView.fromMap(map);
  factory CategoryView.fromMap(Map<String, dynamic> map) {
    return CategoryView(
      id: map['id'],
      code: map['code'],
      name: map['name'],
    );
  }

  String toJson() => json.encode(toMap());

  factory CategoryView.fromJson(String source) => CategoryView.fromMap(json.decode(source));

  @override
  String toString() => 'CategoryView(id: $id, code: $code, name: $name)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CategoryView && other.id == id;
  }

  @override
  int get hashCode => id.hashCode ^ code.hashCode ^ name.hashCode;
}
