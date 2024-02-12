import 'dart:convert';

import 'package:collection/collection.dart';

class InitiateModel {
  final String email;
  final String currency = "NGN";
  final String amount;
  final String reference;
  final List<String> channels = const [
    "card",
    "bank",
    "ussd",
    "qr",
    "mobile_money",
    "bank_transfer",
    "eft"
  ];
  final String? metadata;

  InitiateModel({
    required this.email,
    required this.amount,
    required this.reference,
    this.metadata,
  });

  InitiateModel copyWith({
    String? email,
    String? amount,
    String? reference,
    String? metadata,
  }) {
    return InitiateModel(
      email: email ?? this.email,
      amount: amount ?? this.amount,
      reference: reference ?? this.reference,
      metadata: metadata ?? this.metadata,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'email': email});
    result.addAll({'amount': amount});
    result.addAll({'reference': reference});
    if (metadata != null) {
      result.addAll({'metadata': metadata});
    }

    return result;
  }

  factory InitiateModel.fromMap(Map<String, dynamic> map) {
    return InitiateModel(
      email: map['email'] ?? '',
      amount: map['amount'] ?? '',
      reference: map['reference'] ?? '',
      metadata: map['metadata'],
    );
  }

  String toJson() => json.encode(toMap());

  factory InitiateModel.fromJson(String source) =>
      InitiateModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'InitiateModel(email: $email, amount: $amount, reference: $reference, metadata: $metadata)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is InitiateModel &&
        other.email == email &&
        other.amount == amount &&
        other.reference == reference &&
        other.metadata == metadata;
  }

  @override
  int get hashCode {
    return email.hashCode ^
        amount.hashCode ^
        reference.hashCode ^
        metadata.hashCode;
  }
}
