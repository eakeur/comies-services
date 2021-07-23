import 'dart:convert';

import 'package:comies/core.dart';

class CustomerFilter implements DataModel, Filter {
  int? skip;
  String? name;
  String? phoneNumber;
  
  CustomerFilter({
    this.skip,
    this.name,
    this.phoneNumber,
  });

  CustomerFilter copyWith({
    int? skip,
    String? name,
    String? phoneNumber,
  }) {
    return CustomerFilter(
      skip: skip ?? this.skip,
      name: name ?? this.name,
      phoneNumber: phoneNumber ?? this.phoneNumber,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'skip': skip,
      'name': name,
      'phoneNumber': phoneNumber,
    };
  }

  factory CustomerFilter.fromMap(Map<String, dynamic> map) {
    return CustomerFilter(
      skip: map['skip'],
      name: map['name'],
      phoneNumber: map['phoneNumber'],
    );
  }

  String toJson() => json.encode(toMap());

  factory CustomerFilter.fromJson(String source) => CustomerFilter.fromMap(json.decode(source));

  @override
  String toString() => 'CustomerFilter(skip: $skip, name: $name, phoneNumber: $phoneNumber)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is CustomerFilter &&
      other.skip == skip &&
      other.name == name &&
      other.phoneNumber == phoneNumber;
  }

  @override
  int get hashCode => skip.hashCode ^ name.hashCode ^ phoneNumber.hashCode;
}
