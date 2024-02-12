import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class Categories {
  final String name;
  final String id;
  Categories({
    required this.name,
    required this.id,
  });

  Categories copyWith({
    String? name,
    String? id,
  }) {
    return Categories(
      name: name ?? this.name,
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'name': name});
    result.addAll({'id': id});

    return result;
  }

  factory Categories.fromMap(Map<String, dynamic> map) {
    return Categories(
      name: map['name'] ?? '',
      id: map['id'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Categories.fromJson(String source) =>
      Categories.fromMap(json.decode(source));

  @override
  String toString() => 'Categories(name: $name, id: $id)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Categories && other.name == name && other.id == id;
  }

  @override
  int get hashCode => name.hashCode ^ id.hashCode;
}

final orderProvider = StateProvider<Categories?>((ref) => null);
