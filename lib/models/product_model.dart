import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final List<Map<String, dynamic>> product_list = [
  {
    'imageUrl': [
      'images/bag (1).jpg',
    ],
    'id': 1,
    'title': "women's purse",
    'price': 54.70,
    'company': 'gucci',
    'size': [8, 9, 10, 12, 13, 14, 15, 16, 17],
    'itemCount': 12
  },
  {
    'id': 2,
    'title': "women's shoe",
    'price': 44.20,
    'company': 'ballet',
    'size': [8, 10, 16, 17],
    'imageUrl': ['images/bag (2).jpg'],
    'itemCount': 12
  },
  {
    'id': 3,
    'title': "the louvre",
    'price': 22.40,
    'company': 'fendi',
    'size': [7, 8, 9, 14, 16, 12, 27],
    'imageUrl': ['images/bag (3).jpg'],
    'itemCount': 12
  },
  {
    'id': 4,
    'title': "women's handbag",
    'price': 54.43,
    'company': 'gucci',
    'size': [8, 9, 10, 11],
    'imageUrl': ['images/bag (4).jpg'],
    'itemCount': 12
  },
  {
    'id': 5,
    'title': "katafe cloth",
    'price': 74.49,
    'company': 'ballet',
    'size': [8, 9, 10],
    'imageUrl': ['images/bag (5).jpg'],
    'itemCount': 12
  },
  {
    'id': 6,
    'title': "sceneric purse",
    'price': 54.4,
    'company': 'fendi',
    'size': [8, 9, 11, 12],
    'imageUrl': ['images/bags (6).jpg'],
    'itemCount': 12
  },
  {
    'id': 7,
    'title': "memoir lipgloss",
    'price': 84.4,
    'company': 'ballet',
    'size': [8, 9, 10, 12, 16, 17],
    'imageUrl': ['images/cos (3).jpg'],
    'itemCount': 12
  },
  {
    'id': 8,
    'title': "pancake",
    'price': 54.4,
    'company': 'louis vitton',
    'size': [8, 9, 10],
    'imageUrl': ['images/cos (2).jpg'],
    'itemCount': 12
  }
];

@immutable
class Product {
  const Product({
    required this.id,
    required this.title,
    required this.price,
    required this.company,
    required this.size,
    required this.imageUrl,
    required this.itemCount,
    required this.categoryId,
  });
  final String id;
  final String title;
  final double price;
  final String company;
  final List size;
  final List imageUrl;
  final int itemCount;
  final String categoryId;

  Product copyWith({
    String? id,
    String? title,
    double? price,
    String? company,
    List? size,
    List? imageUrl,
    int? itemCount,
    String? categoryId,
  }) {
    return Product(
      id: id ?? this.id,
      title: title ?? this.title,
      price: price ?? this.price,
      company: company ?? this.company,
      size: size ?? this.size,
      imageUrl: imageUrl ?? this.imageUrl,
      itemCount: itemCount ?? this.itemCount,
      categoryId: categoryId ?? this.categoryId,
    );
  }

  // Product merge(Product model) {
  //   return Product(
  //     id: model.id ?? id,
  //     title: model.title ?? title,
  //     price: model.price ?? price,
  //     company: model.company ?? company,
  //     size: model.size ?? size,
  //     imageUrl: model.imageUrl ?? imageUrl,
  //   );
  // }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'title': title});
    result.addAll({'price': price});
    result.addAll({'company': company});
    result.addAll({'size': size});
    result.addAll({'imageUrl': imageUrl});
    result.addAll({'itemCount': itemCount});
    result.addAll({'categoryId': categoryId});

    return result;
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'] ?? '',
      title: map['title'] ?? '',
      price: map['price']?.toDouble() ?? 0.0,
      company: map['company'] ?? '',
      size: List.from(map['size']),
      imageUrl: List.from(map['imageUrl']),
      itemCount: map['itemCount']?.toInt() ?? 0,
      categoryId: map['categoryId'] ?? '',
    );
  }

  // String toJson() => json.encode(toMap());

  // factory Product.fromJson(String source) =>
  //     Product.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Product(id: $id, title: $title, price: $price, company: $company, size: $size, imageUrl: $imageUrl, itemCount: $itemCount, categoryId: $categoryId)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Product &&
        other.id == id &&
        other.title == title &&
        other.price == price &&
        other.company == company &&
        listEquals(other.size, size) &&
        listEquals(other.imageUrl, imageUrl) &&
        other.itemCount == itemCount &&
        other.categoryId == categoryId;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        price.hashCode ^
        company.hashCode ^
        size.hashCode ^
        imageUrl.hashCode ^
        itemCount.hashCode ^
        categoryId.hashCode;
  }

  String toJson() => json.encode(toMap());

  factory Product.fromJson(String source) =>
      Product.fromMap(json.decode(source));
}

final productProvider = StateProvider<Product?>((ref) => null);
