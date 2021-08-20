import 'dart:convert';
import 'package:comies/core.dart';

class Stock implements StoreOwnedEntity {
  String? productId;
  String? date;
  double? minimum;
  double? maximum;
  double? actual;
  String? location;
  Unity? stockUnity;

  @override
  bool? active;

  @override
  DateTime? creationDate;

  @override
  String? id;

  @override
  String? storeId;
  Stock({
    this.productId = guidEmpty,
    this.date,
    this.minimum = 0,
    this.maximum = 0,
    this.actual = 0,
    this.location = "",
    this.stockUnity,
    this.active = true,
    this.creationDate,
    this.id = guidEmpty,
    this.storeId = guidEmpty,
  });

  Stock copyWith({
    String? productId,
    String? date,
    double? minimum,
    double? maximum,
    double? actual,
    String? location,
    Unity? stockUnity,
    String? mainSupplierId,
    bool? active,
    DateTime? creationDate,
    String? id,
    String? storeId,
  }) {
    return Stock(
      productId: productId ?? this.productId,
      date: date ?? this.date,
      minimum: minimum ?? this.minimum,
      maximum: maximum ?? this.maximum,
      actual: actual ?? this.actual,
      location: location ?? this.location,
      stockUnity: stockUnity ?? this.stockUnity,
      active: active ?? this.active,
      creationDate: creationDate ?? this.creationDate,
      id: id ?? this.id,
      storeId: storeId ?? this.storeId,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'productId': productId,
      'date': date,
      'minimum': minimum,
      'maximum': maximum,
      'actual': actual,
      'location': location,
      'stockUnity': stockUnity?.index,
      'active': active,
      'creationDate': creationDate?.toIso8601String(),
      'id': id,
      'storeId': storeId,
    };
  }

  Stock fromMap(Map<String, dynamic> map) => Stock.fromMap(map);

  factory Stock.fromMap(Map<String, dynamic> map) {
    return Stock(
      productId: map['productId'],
      date: map['date'],
      minimum: map['minimum'] * 1.00,
      maximum: map['maximum'] * 1.00,
      actual: map['actual'] * 1.00,
      location: map['location'],
      stockUnity: Unity.values[map['stockUnity'] ?? 0],
      active: map['active'],
      creationDate: DateTime.parse(map['creationDate']),
      id: map['id'],
      storeId: map['storeId'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Stock.fromJson(String source) => Stock.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Stock(productId: $productId, date: $date, minimum: $minimum, maximum: $maximum, actual: $actual, location: $location, stockUnity: $stockUnity, active: $active, creationDate: $creationDate, id: $id, storeId: $storeId)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Stock &&
        other.productId == productId &&
        other.date == date &&
        other.minimum == minimum &&
        other.maximum == maximum &&
        other.actual == actual &&
        other.location == location &&
        other.stockUnity == stockUnity &&
        other.active == active &&
        other.creationDate == creationDate &&
        other.id == id &&
        other.storeId == storeId;
  }

  @override
  int get hashCode {
    return productId.hashCode ^
        date.hashCode ^
        minimum.hashCode ^
        maximum.hashCode ^
        actual.hashCode ^
        location.hashCode ^
        stockUnity.hashCode ^
        active.hashCode ^
        creationDate.hashCode ^
        id.hashCode ^
        storeId.hashCode;
  }
}
