import 'dart:convert';

import 'package:comies/core.dart';

class Customer implements Entity {
  String? name;
  String? document;
  String? memberSince;

  Customer({
    this.name,
    this.document,
    this.memberSince,
  });

  Customer copyWith({
    String? name,
    String? document,
    String? memberSince,
  }) {
    return Customer(
      name: name ?? this.name,
      document: document ?? this.document,
      memberSince: memberSince ?? this.memberSince,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'document': document,
      'memberSince': memberSince,
    };
  }

  factory Customer.fromMap(Map<String, dynamic> map) {
    return Customer(
      name: map['name'],
      document: map['document'],
      memberSince: map['memberSince'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Customer.fromJson(String source) => Customer.fromMap(json.decode(source));

  @override
  String toString() => 'Customer(name: $name, document: $document, memberSince: $memberSince)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Customer && other.name == name && other.document == document && other.memberSince == memberSince;
  }

  @override
  int get hashCode => name.hashCode ^ document.hashCode ^ memberSince.hashCode;

  @override
  bool? active;

  @override
  DateTime? creationDate;

  @override
  String? id;
}
