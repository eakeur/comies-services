import 'dart:convert';
import 'package:datacontext/datacontext.dart';

class CategoryView extends DataClass {
  String? description;
  int? skip;
  String? code;
  String? name;
  String? parentId;

  CategoryView({
    this.description,
    this.skip,
    this.code,
    this.name,
    this.parentId,
  });

  CategoryView copyWith({
    String? description,
    int? skip,
    String? code,
    String? name,
    String? parentId,
  }) {
    return CategoryView(
      description: description ?? this.description,
      skip: skip ?? this.skip,
      code: code ?? this.code,
      name: name ?? this.name,
      parentId: parentId ?? this.parentId,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'description': description,
      'skip': skip,
      'code': code,
      'name': name,
      'parentId': parentId,
    };
  }

  CategoryView fromMap(Map<String, dynamic> map) => CategoryView.fromMap(map);
  factory CategoryView.fromMap(Map<String, dynamic> map) {
    return CategoryView(
      description: map['description'],
      skip: map['skip'],
      code: map['code'],
      name: map['name'],
      parentId: map['parentId'],
    );
  }

  String toJson() => json.encode(toMap());

  factory CategoryView.fromJson(String source) => CategoryView.fromMap(json.decode(source));

  @override
  String toString() {
    return 'CategoryFilter(description: $description, skip: $skip, code: $code, name: $name, parentId: $parentId)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CategoryView && other.description == description && other.skip == skip && other.code == code && other.name == name && other.parentId == parentId;
  }

  @override
  int get hashCode {
    return description.hashCode ^ skip.hashCode ^ code.hashCode ^ name.hashCode ^ parentId.hashCode;
  }
}
