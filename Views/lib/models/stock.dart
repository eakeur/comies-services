import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:comies/core.dart';
import 'package:comies/models/stock-movement.dart';

class Stock implements StoreOwnedEntity {
  String? productId;
  String? date;
  double? minimum;
  double? maximum;
  double? actual;
  String? location;
  Unity? stockUnity;
  String? mainSupplierId;
  List<StockMovement>? movements;

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
    this.mainSupplierId = guidEmpty,
    this.movements,
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
    List<StockMovement>? movements,
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
      mainSupplierId: mainSupplierId ?? this.mainSupplierId,
      movements: movements ?? this.movements,
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
      'mainSupplierId': mainSupplierId,
      'movements': movements?.map((x) => x.toMap()).toList(),
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
      mainSupplierId: map['mainSupplierId'],
      movements: List<StockMovement>.from(map['movements']?.map((x) => StockMovement.fromMap(x))),
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
    return 'Stock(productId: $productId, date: $date, minimum: $minimum, maximum: $maximum, actual: $actual, location: $location, stockUnity: $stockUnity, mainSupplierId: $mainSupplierId, movements: $movements, active: $active, creationDate: $creationDate, id: $id, storeId: $storeId)';
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
        other.mainSupplierId == mainSupplierId &&
        listEquals(other.movements, movements) &&
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
        mainSupplierId.hashCode ^
        movements.hashCode ^
        active.hashCode ^
        creationDate.hashCode ^
        id.hashCode ^
        storeId.hashCode;
  }
}
