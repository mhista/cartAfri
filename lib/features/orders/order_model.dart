import 'dart:convert';

import 'package:flutter/foundation.dart';

class Orders {
  final String id;
  final String userId;
  final DateTime startDate;
  final DateTime orderedDate;
  final bool ordered;
  final int quantity;
  final String shippingAddress;
  final String billingAddress;
  final List orderItemIds;
  Orders({
    required this.id,
    required this.userId,
    required this.startDate,
    required this.orderedDate,
    required this.ordered,
    required this.quantity,
    required this.shippingAddress,
    required this.billingAddress,
    required this.orderItemIds,
  });

  Orders copyWith({
    String? id,
    String? userId,
    DateTime? startDate,
    DateTime? orderedDate,
    bool? ordered,
    int? quantity,
    String? shippingAddress,
    String? billingAddress,
    List? orderItemIds,
  }) {
    return Orders(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      startDate: startDate ?? this.startDate,
      orderedDate: orderedDate ?? this.orderedDate,
      ordered: ordered ?? this.ordered,
      quantity: quantity ?? this.quantity,
      shippingAddress: shippingAddress ?? this.shippingAddress,
      billingAddress: billingAddress ?? this.billingAddress,
      orderItemIds: orderItemIds ?? this.orderItemIds,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'userId': userId});
    result.addAll({'startDate': startDate.millisecondsSinceEpoch});
    result.addAll({'orderedDate': orderedDate.millisecondsSinceEpoch});
    result.addAll({'ordered': ordered});
    result.addAll({'quantity': quantity});
    result.addAll({'shippingAddress': shippingAddress});
    result.addAll({'billingAddress': billingAddress});
    result.addAll({'orderItemIds': orderItemIds});

    return result;
  }

  factory Orders.fromMap(Map<String, dynamic> map) {
    return Orders(
      id: map['id'] ?? '',
      userId: map['userId'] ?? '',
      startDate: DateTime.fromMillisecondsSinceEpoch(map['startDate']),
      orderedDate: DateTime.fromMillisecondsSinceEpoch(map['orderedDate']),
      ordered: map['ordered'] ?? false,
      quantity: map['quantity']?.toInt() ?? 0,
      shippingAddress: map['shippingAddress'] ?? '',
      billingAddress: map['billingAddress'] ?? '',
      orderItemIds: List.from(map['orderItemIds']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Orders.fromJson(String source) => Orders.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Orders(id: $id, userId: $userId, startDate: $startDate, orderedDate: $orderedDate, ordered: $ordered, quantity: $quantity, shippingAddress: $shippingAddress, billingAddress: $billingAddress, orderItemIds: $orderItemIds)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Orders &&
        other.id == id &&
        other.userId == userId &&
        other.startDate == startDate &&
        other.orderedDate == orderedDate &&
        other.ordered == ordered &&
        other.quantity == quantity &&
        other.shippingAddress == shippingAddress &&
        other.billingAddress == billingAddress &&
        listEquals(other.orderItemIds, orderItemIds);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        userId.hashCode ^
        startDate.hashCode ^
        orderedDate.hashCode ^
        ordered.hashCode ^
        quantity.hashCode ^
        shippingAddress.hashCode ^
        billingAddress.hashCode ^
        orderItemIds.hashCode;
  }
}
