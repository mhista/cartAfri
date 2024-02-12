import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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

  void addItemToOrder(String id) => orderItems.add(id);
  void removeItemFromOrder(String id) => orderItems.remove(id);
}

final orderProvider = StateProvider<Order?>((ref) => null);
