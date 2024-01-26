import 'dart:convert';

import 'package:cartafri/features/order_items/order_item_model.dart';
import 'package:collection/collection.dart';
// / import 'package:flutter/foundation.dart';

class Orders {
  final String id;
  final String userId;
  final DateTime startDate;
  final DateTime? orderedDate;
  final bool ordered;
  final String? shippingAddress;
  final String? billingAddress;
  final List orderItems;
  Orders({
    required this.id,
    required this.userId,
    required this.startDate,
    required this.orderedDate,
    required this.ordered,
    required this.shippingAddress,
    required this.billingAddress,
    required this.orderItems,
  });

  Orders copyWith({
    String? id,
    String? userId,
    DateTime? startDate,
    DateTime? orderedDate,
    bool? ordered,
    String? shippingAddress,
    String? billingAddress,
    List? orderItems,
  }) {
    return Orders(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      startDate: startDate ?? this.startDate,
      orderedDate: orderedDate ?? this.orderedDate,
      ordered: ordered ?? this.ordered,
      shippingAddress: shippingAddress ?? this.shippingAddress,
      billingAddress: billingAddress ?? this.billingAddress,
      orderItems: orderItems ?? this.orderItems,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'userId': userId});
    result.addAll({'startDate': startDate.millisecondsSinceEpoch});
    if (orderedDate != null) {
      result.addAll({'orderedDate': orderedDate!.millisecondsSinceEpoch});
    }
    result.addAll({'ordered': ordered});
    if (shippingAddress != null) {
      result.addAll({'shippingAddress': shippingAddress});
    }
    if (billingAddress != null) {
      result.addAll({'billingAddress': billingAddress});
    }
    result.addAll({'orderItems': orderItems});

    return result;
  }

  factory Orders.fromMap(Map<String, dynamic> map) {
    return Orders(
      id: map['id'] ?? '',
      userId: map['userId'] ?? '',
      startDate: DateTime.fromMillisecondsSinceEpoch(map['startDate']),
      orderedDate: map['orderedDate'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['orderedDate'])
          : null,
      ordered: map['ordered'] ?? false,
      shippingAddress: map['shippingAddress'],
      billingAddress: map['billingAddress'],
      orderItems: List.from(map['orderItems']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Orders.fromJson(String source) => Orders.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Orders(id: $id, userId: $userId, startDate: $startDate, orderedDate: $orderedDate, ordered: $ordered, shippingAddress: $shippingAddress, billingAddress: $billingAddress, orderItems: $orderItems)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return other is Orders &&
        other.id == id &&
        other.userId == userId &&
        other.startDate == startDate &&
        other.orderedDate == orderedDate &&
        other.ordered == ordered &&
        other.shippingAddress == shippingAddress &&
        other.billingAddress == billingAddress &&
        listEquals(other.orderItems, orderItems);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        userId.hashCode ^
        startDate.hashCode ^
        orderedDate.hashCode ^
        ordered.hashCode ^
        shippingAddress.hashCode ^
        billingAddress.hashCode ^
        orderItems.hashCode;
  }
}
