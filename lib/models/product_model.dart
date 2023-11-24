import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final product_list = [
  {
    'id': 1,
    'title': "women's handbag",
    'price': 54.70,
    'company': 'gucci',
    'size': [8, 9, 10]
  },
  {
    'id': 2,
    'title': "women's wallet",
    'price': 44.20,
    'company': 'ballet',
    'size': [8, 10]
  },
  {
    'id': 3,
    'title': "the louvre",
    'price': 22.40,
    'company': 'fendi',
    'size': [7, 8, 9]
  },
  {
    'id': 4,
    'title': "women's handbag",
    'price': 54.43,
    'company': 'gucci',
    'size': [8, 9, 10, 11]
  },
  {
    'id': 5,
    'title': "katafe handbag",
    'price': 74.49,
    'company': 'ballet',
    'size': [8, 9, 10]
  },
  {
    'id': 6,
    'title': "sceneric purse",
    'price': 54.4,
    'company': 'fendi',
    'size': [8, 9, 11, 12]
  },
  {
    'id': 7,
    'title': "memoir cloth",
    'price': 84.4,
    'company': 'ballet',
    'size': [8, 9, 10]
  },
  {
    'id': 8,
    'title': "handbag",
    'price': 54.4,
    'company': 'louis vitton',
    'size': [8, 9, 10]
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
  });
  final int id;
  final String title;
  final double price;
  final String company;
  final int size;
  final String imageUrl;

  Cart copyWith({
    String? title,
    double? price,
    String? company,
    int? size,
    String? imageUrl,
  }) {
    return Cart(
      id: id ?? this.id,
      title: title ?? this.title,
      price: price ?? this.price,
      company: '',
      size: size ?? this.size,
      imageUrl: '',
    );
  }
}

class CartProvider extends StateNotifier {
  CartProvider()
      : super(Cart(
            id: 0, title: '', price: 0.0, company: '', size: 0, imageUrl: ''));
  final List<Map<String, dynamic>> cart = [];
  void addToCart(Map p) {
    state = state.copyWith(
      id: p['id'],
      title: p['title'],
      price: p['price'],
      company: p['company'],
      size: p['size'],
      imageUrl: p['imageUrl'],
    );
    cart.add(state);
  }

  void removeFromCart(Map p) {
    state = state.copyWith(
      id: p['id'],
      title: p['title'],
      price: p['price'],
      company: p['company'],
      size: p['size'],
      imageUrl: p['imageUrl'],
    );
    cart.remove(state);
  }
}
