import 'dart:convert';

import 'package:comies/core.dart';

class StockMovement implements StoreOwnedEntity {
  String? stockId;
  StockMovementType? type;
  String? effectiveDate;
  double? quantity;
  double? unityPrice;
  double? otherCosts;
  String? orderId;
  String? supplierId;
  String? document;
  String? observations;

  @override
  bool? active;

  @override
  DateTime? creationDate;

  @override
  String? id;

  @override
  String? storeId;
  StockMovement({
    this.type,
    this.stockId,
    this.effectiveDate,
    this.quantity,
    this.unityPrice,
    this.otherCosts,
    this.orderId,
    this.supplierId,
    this.document,
    this.observations,
    this.active,
    this.creationDate,
    this.id,
    this.storeId,
  });

  StockMovement copyWith({
    String? stockId,
    String? effectiveDate,
    double? quantity,
    double? unityPrice,
    double? otherCosts,
    String? orderId,
    String? supplierId,
    String? document,
    String? observations,
    bool? active,
    DateTime? creationDate,
    String? id,
    String? storeId,
    StockMovementType? type,
  }) {
    return StockMovement(
      type: type ?? this.type,
      stockId: stockId ?? this.stockId,
      effectiveDate: effectiveDate ?? this.effectiveDate,
      quantity: quantity ?? this.quantity,
      unityPrice: unityPrice ?? this.unityPrice,
      otherCosts: otherCosts ?? this.otherCosts,
      orderId: orderId ?? this.orderId,
      supplierId: supplierId ?? this.supplierId,
      document: document ?? this.document,
      observations: observations ?? this.observations,
      active: active ?? this.active,
      creationDate: creationDate ?? this.creationDate,
      id: id ?? this.id,
      storeId: storeId ?? this.storeId,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'stockId': stockId,
      'effectiveDate': effectiveDate,
      'quantity': quantity,
      'unityPrice': unityPrice,
      'otherCosts': otherCosts,
      'orderId': orderId,
      'supplierId': supplierId,
      'document': document,
      'observations': observations,
      'active': active,
      'creationDate': creationDate?.toIso8601String(),
      'id': id,
      'storeId': storeId,
      'type': type?.index
    };
  }

  StockMovement fromMap(Map<String, dynamic> map) => StockMovement.fromMap(map);

  factory StockMovement.fromMap(Map<String, dynamic> map) {
    return StockMovement(
        stockId: map['stockId'],
        effectiveDate: map['effectiveDate'],
        quantity: map['quantity'],
        unityPrice: map['unityPrice'],
        otherCosts: map['otherCosts'],
        orderId: map['orderId'],
        supplierId: map['supplierId'],
        document: map['document'],
        observations: map['observations'],
        active: map['active'],
        creationDate: DateTime.fromMillisecondsSinceEpoch(map['creationDate']),
        id: map['id'],
        storeId: map['storeId'],
        type: StockMovementType.values[map['type'] ?? 0]);
  }

  String toJson() => json.encode(toMap());

  factory StockMovement.fromJson(String source) => StockMovement.fromMap(json.decode(source));

  @override
  String toString() {
    return 'StockMovement(stockId: $stockId, effectiveDate: $effectiveDate, quantity: $quantity, unityPrice: $unityPrice, otherCosts: $otherCosts, orderId: $orderId, supplierId: $supplierId, document: $document, observations: $observations, active: $active, creationDate: $creationDate, id: $id, storeId: $storeId)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is StockMovement &&
        other.stockId == stockId &&
        other.effectiveDate == effectiveDate &&
        other.quantity == quantity &&
        other.unityPrice == unityPrice &&
        other.otherCosts == otherCosts &&
        other.orderId == orderId &&
        other.supplierId == supplierId &&
        other.document == document &&
        other.observations == observations &&
        other.active == active &&
        other.creationDate == creationDate &&
        other.id == id &&
        other.storeId == storeId;
  }

  @override
  int get hashCode {
    return stockId.hashCode ^
        effectiveDate.hashCode ^
        quantity.hashCode ^
        unityPrice.hashCode ^
        otherCosts.hashCode ^
        orderId.hashCode ^
        supplierId.hashCode ^
        document.hashCode ^
        observations.hashCode ^
        active.hashCode ^
        creationDate.hashCode ^
        id.hashCode ^
        storeId.hashCode;
  }
}
