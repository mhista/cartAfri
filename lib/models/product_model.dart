import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final product_list = [
  {
    'id': 1,
    'title': "women's handbag",
    'price': 54.70,
    'company': 'gucci',
    'size': [8, 9, 10, 12, 13, 14, 15, 16, 17],
    'image': [
      'images/bag (1).jpg',
    ]
  },
  {
    'id': 2,
    'title': "women's wallet",
    'price': 44.20,
    'company': 'ballet',
    'size': [8, 10, 16, 17],
    'image': [
      'images/bag (2).jpg',
    ]
  },
  {
    'id': 3,
    'title': "the louvre",
    'price': 22.40,
    'company': 'fendi',
    'size': [7, 8, 9, 14, 16, 12, 27],
    'image': [
      'images/bag (3).jpg',
    ]
  },
  {
    'id': 4,
    'title': "women's handbag",
    'price': 54.43,
    'company': 'gucci',
    'size': [8, 9, 10, 11],
    'image': [
      'images/bag (4).jpg',
    ]
  },
  {
    'id': 5,
    'title': "katafe handbag",
    'price': 74.49,
    'company': 'ballet',
    'size': [8, 9, 10],
    'image': [
      'images/bag (5).jpg',
    ]
  },
  {
    'id': 6,
    'title': "sceneric purse",
    'price': 54.4,
    'company': 'fendi',
    'size': [8, 9, 11, 12],
    'image': [
      'images/bags (6).jpg',
    ]
  },
  {
    'id': 7,
    'title': "memoir cloth",
    'price': 84.4,
    'company': 'ballet',
    'size': [8, 9, 10, 12, 16, 17],
    'image': [
      'images/cos (3).jpg',
    ]
  },
  {
    'id': 8,
    'title': "handbag",
    'price': 54.4,
    'company': 'louis vitton',
    'size': [8, 9, 10],
    'image': [
      'images/cos (2).jpg',
    ]
  }
];

@immutable
class Cart {
  Cart({
    required this.id,
    required this.title,
    required this.price,
    required this.company,
    required this.size,
    required this.imageUrl,
    required this.itemCount,
  });
  final int id;
  final String title;
  final double price;
  final String company;
  final int size;
  final String imageUrl;
  int itemCount;

  Cart copyWith({
    int? id,
    String? title,
    double? price,
    String? company,
    int? size,
    String? imageUrl,
    int? itemCount,
  }) {
    return Cart(
      id: id ?? this.id,
      title: title ?? this.title,
      price: price ?? this.price,
      company: company ?? this.company,
      size: size ?? this.size,
      imageUrl: imageUrl ?? this.imageUrl,
      itemCount: itemCount ?? this.itemCount,
    );
  }

  // Cart merge(Cart model) {
  //   return Cart(
  //     id: model.id ?? id,
  //     title: model.title ?? title,
  //     price: model.price ?? price,
  //     company: model.company ?? company,
  //     size: model.size ?? size,
  //     imageUrl: model.imageUrl ?? imageUrl,
  //   );
  // }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'price': price,
      'company': company,
      'size': size,
      'imageUrl': imageUrl,
      'itemCount': itemCount,
    };
  }

  factory Cart.fromMap(Map<String, dynamic> map) {
    return Cart(
      id: map['id'] ?? 0,
      title: map['title'] ?? '',
      price: map['price'] ?? 0.0,
      company: map['company'] ?? '',
      size: map['size'] ?? 0,
      imageUrl: map['imageUrl'] ?? 0,
      itemCount: map['itemCount'] ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Cart.fromJson(String source) => Cart.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Cart(id: $id, title: $title, price: $price, company: $company, size: $size, imageUrl: $imageUrl, itemCount: $itemCount)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Cart &&
        o.id == id &&
        o.title == title &&
        o.price == price &&
        o.company == company &&
        o.size == size &&
        o.imageUrl == imageUrl;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        price.hashCode ^
        company.hashCode ^
        size.hashCode ^
        itemCount.hashCode ^
        imageUrl.hashCode;
  }
}

final cartProviderNotifier = Provider((ref) => CartProvider());

class CartProvider extends StateNotifier<Cart> {
  CartProvider()
      : super(Cart(
            id: 0,
            title: '',
            price: 0.0,
            company: '',
            size: 0,
            imageUrl: '',
            itemCount: 0));
  final List<Cart> _cart = [];
  void removeFromCart(Map<String, dynamic> p) {
    state = state.copyWith(
      id: p['id'],
      title: p['title'],
      price: p['price'],
      company: p['company'],
      size: p['size'],
      imageUrl: p['imageUrl'],
      itemCount: p['itemCount'],
    );
    _cart.remove(state);
  }

  get cart => _cart;
  void addToCart(Map<String, dynamic> p) {
    state = state.copyWith(
      id: p['id'],
      title: p['title'],
      price: p['price'],
      company: p['company'],
      size: p['size'],
      itemCount: p['itemCount'],
      imageUrl: p['imageUrl'],
    );
    if (_cart.isEmpty) {
      print('cart is empty');
      _cart.add(state);
      print('added product ${_cart}');
    } else if (_cart.isNotEmpty) {
      print(_cart.length);
      if (_cart.length == 1 && _cart[0].id == (p["id"] as int)) {
        print('same object ${_cart[0]}');
        _cart[0].itemCount = _cart[0].itemCount += 1;
        print(_cart);
      } else if (_cart.length == 1 && _cart[0].id != (p["id"] as int)) {
        print('cart is not empty');
        _cart.add(state);
        print('added product ${_cart}');
      } else {
        int hi = _cart.length;
        int low = 0;
        while (low <= hi) {
          var mid = (hi + low) % 2;
          print(mid);
          var midNumber = _cart[mid];
          print(midNumber);
          if ((p['id'] as int) == midNumber.id) {
            print('yes middle');
            midNumber.itemCount += 1;
          } else if (midNumber.id < (p['id'] as int)) {
            print('found at low');
            low = mid;
          } else if (midNumber.id > (p['id'] as int)) {
            print('found at hi');
            low = mid;
          } else {
            _cart.add(state);
            print('created new');
          }
        }
      }
    }
  }
}
