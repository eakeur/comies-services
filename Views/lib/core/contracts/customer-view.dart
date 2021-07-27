import 'dart:convert';

import 'package:comies/core.dart';

class CustomerView implements DataModel {
  String? id;
  String? name;
  Phone? phone;

  CustomerView({
    this.id,
    this.name,
    this.phone,
  });

  CustomerView copyWith({
    String? id,
    String? name,
    Phone? phone,
  }) {
    return CustomerView(
      id: id ?? this.id,
      name: name ?? this.name,
      phone: phone ?? this.phone,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'phone': phone?.toMap(),
    };
  }

  factory CustomerView.fromMap(Map<String, dynamic> map) {
    return CustomerView(
      id: map['id'],
      name: map['name'],
      phone: Phone.fromMap(map['phone'] ?? {}),
    );
  }

  String toJson() => json.encode(toMap());

  factory CustomerView.fromJson(String source) => CustomerView.fromMap(json.decode(source));

  @override
  String toString() => 'ProductView(id: $id, name: $name, phone: $phone)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CustomerView && other.id == id && other.name == name && other.phone == phone;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ phone.hashCode;
}
