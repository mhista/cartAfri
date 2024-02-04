import 'dart:convert';

import 'package:cartafri/services/payment/customers.dart';

class Transaction {
  int? id;
  String? domain;
  String? status;
  String? reference;
  int? amount;
  String? message;
  String? gatewayResponse;
  String? paidAt;
  String? createdAt;
  String? channel;
  String? currency;
  int? fees;
  Customer? customer;

  Transaction(
      this.id,
      this.domain,
      this.status,
      this.reference,
      this.amount,
      this.message,
      this.gatewayResponse,
      this.paidAt,
      this.createdAt,
      this.channel,
      this.currency,
      this.fees,
      this.customer);

  Transaction copyWith({
    int? id,
    String? domain,
    String? status,
    String? reference,
    int? amount,
    String? message,
    String? gatewayResponse,
    String? paidAt,
    String? createdAt,
    String? channel,
    String? currency,
    int? fees,
    Customer? customer,
  }) {
    return Transaction(
      id ?? this.id,
      domain ?? this.domain,
      status ?? this.status,
      reference ?? this.reference,
      amount ?? this.amount,
      message ?? this.message,
      gatewayResponse ?? this.gatewayResponse,
      paidAt ?? this.paidAt,
      createdAt ?? this.createdAt,
      channel ?? this.channel,
      currency ?? this.currency,
      fees ?? this.fees,
      customer ?? this.customer,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (id != null) {
      result.addAll({'id': id});
    }
    if (domain != null) {
      result.addAll({'domain': domain});
    }
    if (status != null) {
      result.addAll({'status': status});
    }
    if (reference != null) {
      result.addAll({'reference': reference});
    }
    if (amount != null) {
      result.addAll({'amount': amount});
    }
    if (message != null) {
      result.addAll({'message': message});
    }
    if (gatewayResponse != null) {
      result.addAll({'gatewayResponse': gatewayResponse});
    }
    if (paidAt != null) {
      result.addAll({'paidAt': paidAt});
    }
    if (createdAt != null) {
      result.addAll({'createdAt': createdAt});
    }
    if (channel != null) {
      result.addAll({'channel': channel});
    }
    if (currency != null) {
      result.addAll({'currency': currency});
    }
    if (fees != null) {
      result.addAll({'fees': fees});
    }
    if (customer != null) {
      result.addAll({'customer': customer!.toMap()});
    }

    return result;
  }

  factory Transaction.fromMap(Map<String, dynamic> map) {
    return Transaction(
      map['id']?.toInt(),
      map['domain'],
      map['status'],
      map['reference'],
      map['amount']?.toInt(),
      map['message'],
      map['gatewayResponse'],
      map['paidAt'],
      map['createdAt'],
      map['channel'],
      map['currency'],
      map['fees']?.toInt(),
      map['customer'] != null ? Customer.fromMap(map['customer']) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Transaction.fromJson(String source) =>
      Transaction.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Transaction(id: $id, domain: $domain, status: $status, reference: $reference, amount: $amount, message: $message, gatewayResponse: $gatewayResponse, paidAt: $paidAt, createdAt: $createdAt, channel: $channel, currency: $currency, fees: $fees, customer: $customer)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Transaction &&
        other.id == id &&
        other.domain == domain &&
        other.status == status &&
        other.reference == reference &&
        other.amount == amount &&
        other.message == message &&
        other.gatewayResponse == gatewayResponse &&
        other.paidAt == paidAt &&
        other.createdAt == createdAt &&
        other.channel == channel &&
        other.currency == currency &&
        other.fees == fees &&
        other.customer == customer;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        domain.hashCode ^
        status.hashCode ^
        reference.hashCode ^
        amount.hashCode ^
        message.hashCode ^
        gatewayResponse.hashCode ^
        paidAt.hashCode ^
        createdAt.hashCode ^
        channel.hashCode ^
        currency.hashCode ^
        fees.hashCode ^
        customer.hashCode;
  }
}
