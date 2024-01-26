import 'dart:convert';

class OrderItem {
  final String userId;
  final String id;
  final String productId;
  final int quantity;
  final int size;
  OrderItem({
    required this.userId,
    required this.id,
    required this.productId,
    required this.quantity,
    required this.size,
  });

  OrderItem copyWith({
    String? userId,
    String? id,
    String? productId,
    int? quantity,
    int? size,
  }) {
    return OrderItem(
      userId: userId ?? this.userId,
      id: id ?? this.id,
      productId: productId ?? this.productId,
      quantity: quantity ?? this.quantity,
      size: size ?? this.size,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'userId': userId});
    result.addAll({'id': id});
    result.addAll({'productId': productId});
    result.addAll({'quantity': quantity});
    result.addAll({'size': size});

    return result;
  }

  factory OrderItem.fromMap(Map<String, dynamic> map) {
    return OrderItem(
      userId: map['userId'] ?? '',
      id: map['id'] ?? '',
      productId: map['productId'] ?? '',
      quantity: map['quantity']?.toInt() ?? 0,
      size: map['size']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderItem.fromJson(String source) =>
      OrderItem.fromMap(json.decode(source));

  @override
  String toString() {
    return 'OrderItem(userId: $userId, id: $id, productId: $productId, quantity: $quantity, size: $size)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is OrderItem &&
        other.userId == userId &&
        other.id == id &&
        other.productId == productId &&
        other.quantity == quantity &&
        other.size == size;
  }

  @override
  int get hashCode {
    return userId.hashCode ^
        id.hashCode ^
        productId.hashCode ^
        quantity.hashCode ^
        size.hashCode;
  }
}
