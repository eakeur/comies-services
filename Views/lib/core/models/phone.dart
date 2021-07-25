import 'dart:convert';

import 'package:comies/core.dart';

class Phone implements Entity {
  String? ddd;
  String? number;
  String? customerId;

  @override
  bool? active;

  @override
  DateTime? creationDate;

  @override
  String? id;

  Phone({
    this.ddd,
    this.number,
    this.customerId,
    this.active = true,
    this.creationDate,
    this.id = guidEmpty,
  });

  

  Phone copyWith({
    String? ddd,
    String? number,
    String? customerId,
    bool? active,
    DateTime? creationDate,
    String? id,
  }) {
    return Phone(
      ddd: ddd ?? this.ddd,
      number: number ?? this.number,
      customerId: customerId ?? this.customerId,
      active: active ?? this.active,
      creationDate: creationDate ?? this.creationDate,
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'ddd': ddd,
      'number': number,
      'customerId': customerId,
      'active': active,
      'creationDate': creationDate?.toIso8601String(),
      'id': id,
    };
  }

  factory Phone.fromMap(Map<String, dynamic> map) {
    return Phone(
      ddd: map['ddd'],
      number: map['number'],
      customerId: map['customerId'],
      active: map['active'],
      creationDate: DateTime.tryParse(map['creationDate']??''),
      id: map['id'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Phone.fromJson(String source) => Phone.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Phone(ddd: $ddd, number: $number, customerId: $customerId, active: $active, creationDate: $creationDate, id: $id)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is Phone &&
      other.ddd == ddd &&
      other.number == number &&
      other.customerId == customerId &&
      other.active == active &&
      other.creationDate == creationDate &&
      other.id == id;
  }

  @override
  int get hashCode {
    return ddd.hashCode ^
      number.hashCode ^
      customerId.hashCode ^
      active.hashCode ^
      creationDate.hashCode ^
      id.hashCode;
  }
}
