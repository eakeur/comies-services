import 'dart:convert';

import 'package:comies/core.dart';

class Customer implements Entity {
  String? name;
  String? document;
  DateTime? memberSince;

  @override
  bool? active;

  @override
  DateTime? creationDate;

  @override
  String? id;
  Customer({
    this.name,
    this.document,
    this.memberSince,
    this.active = true,
    this.creationDate,
    this.id  = guidEmpty,
  });

  Customer copyWith({
    String? name,
    String? document,
    DateTime? memberSince,
    bool? active,
    DateTime? creationDate,
    String? id,
  }) {
    return Customer(
      name: name ?? this.name,
      document: document ?? this.document,
      memberSince: memberSince ?? this.memberSince,
      active: active ?? this.active,
      creationDate: creationDate ?? this.creationDate,
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'document': document,
      'memberSince': memberSince?.toIso8601String(),
      'active': active,
      'creationDate': creationDate?.toIso8601String(),
      'id': id,
    };
  }

  factory Customer.fromMap(Map<String, dynamic> map) {
    return Customer(
      name: map['name'],
      document: map['document'],
      memberSince: DateTime.parse(map['memberSince']),
      active: map['active'],
      creationDate: DateTime.parse(map['creationDate']),
      id: map['id'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Customer.fromJson(String source) => Customer.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Customer(name: $name, document: $document, memberSince: $memberSince, active: $active, creationDate: $creationDate, id: $id)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is Customer &&
      other.name == name &&
      other.document == document &&
      other.memberSince == memberSince &&
      other.active == active &&
      other.creationDate == creationDate &&
      other.id == id;
  }

  @override
  int get hashCode {
    return name.hashCode ^
      document.hashCode ^
      memberSince.hashCode ^
      active.hashCode ^
      creationDate.hashCode ^
      id.hashCode;
  }
}
