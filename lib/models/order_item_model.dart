import 'dart:convert';

import 'package:cartafri/models/product_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OrderItem {
  final String userId;
  final String id;
  final bool ordered;
  final int quantity;
  final int size;
  final Product product;

  OrderItem({
    required this.userId,
    required this.id,
    required this.ordered,
    required this.quantity,
    required this.size,
    required this.product,
  });

  OrderItem copyWith({
    String? userId,
    String? id,
    bool? ordered,
    int? quantity,
    int? size,
    Product? product,
  }) {
    return OrderItem(
      userId: userId ?? this.userId,
      id: id ?? this.id,
      ordered: ordered ?? this.ordered,
      quantity: quantity ?? this.quantity,
      size: size ?? this.size,
      product: product ?? this.product,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'userId': userId});
    result.addAll({'id': id});
    result.addAll({'ordered': ordered});
    result.addAll({'quantity': quantity});
    result.addAll({'size': size});
    result.addAll({'product': product.toMap()});

    return result;
  }

  factory OrderItem.fromMap(Map<String, dynamic> map) {
    return OrderItem(
      userId: map['userId'] ?? '',
      id: map['id'] ?? '',
      ordered: map['ordered'] ?? false,
      quantity: map['quantity']?.toInt() ?? 0,
      size: map['size']?.toInt() ?? 0,
      product: Product.fromMap(map['product']),
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderItem.fromJson(String source) =>
      OrderItem.fromMap(json.decode(source));

  @override
  String toString() {
    return 'OrderItem(userId: $userId, id: $id, ordered: $ordered, quantity: $quantity, size: $size, product: $product)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is OrderItem &&
        other.userId == userId &&
        other.id == id &&
        other.ordered == ordered &&
        other.quantity == quantity &&
        other.size == size &&
        other.product == product;
  }

  @override
  int get hashCode {
    return userId.hashCode ^
        id.hashCode ^
        ordered.hashCode ^
        quantity.hashCode ^
        size.hashCode ^
        product.hashCode;
  }
}

final orderItemProvider = StateProvider<OrderItem?>((ref) => null);
