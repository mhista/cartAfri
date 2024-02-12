// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

class Customer {
  String? userId;
  String? first_name;
  String? last_name;
  String? phone;
  String? email;
  int? integration;
  String? domain;
  String? customerCode;
  int? id;
  bool? identified;

  Customer(
      {this.first_name,
      this.last_name,
      this.phone,
      this.email,
      this.integration,
      this.domain,
      this.customerCode,
      this.id,
      this.identified});
  Customer copyWith({
    String? first_name,
    String? last_name,
    String? phone,
    String? email,
    int? integration,
    String? domain,
    String? customerCode,
    int? id,
    bool? identified,
  }) {
    return Customer(
      first_name: first_name ?? this.first_name,
      last_name: last_name ?? this.last_name,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      integration: integration ?? this.integration,
      domain: domain ?? this.domain,
      customerCode: customerCode ?? this.customerCode,
      id: id ?? this.id,
      identified: identified ?? this.identified,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (first_name != null) {
      result.addAll({'first_name': first_name});
    }
    if (last_name != null) {
      result.addAll({'last_name': last_name});
    }
    if (phone != null) {
      result.addAll({'phone': phone});
    }
    if (email != null) {
      result.addAll({'email': email});
    }
    if (integration != null) {
      result.addAll({'integration': integration});
    }
    if (domain != null) {
      result.addAll({'domain': domain});
    }
    if (customerCode != null) {
      result.addAll({'customerCode': customerCode});
    }
    if (id != null) {
      result.addAll({'id': id});
    }
    if (identified != null) {
      result.addAll({'identified': identified});
    }

    return result;
  }

  factory Customer.fromMap(Map<String, dynamic> map) {
    return Customer(
      first_name: map['first_name'],
      last_name: map['last_name'],
      phone: map['phone'],
      email: map['email'],
      integration: map['integration']?.toInt(),
      domain: map['domain'],
      customerCode: map['customerCode'],
      id: map['id']?.toInt(),
      identified: map['identified'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Customer.fromJson(String source) =>
      Customer.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Customer(first_name: $first_name, last_name: $last_name, phone: $phone, email: $email, integration: $integration, domain: $domain, customerCode: $customerCode, id: $id, identified: $identified)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Customer &&
        other.first_name == first_name &&
        other.last_name == last_name &&
        other.phone == phone &&
        other.email == email &&
        other.integration == integration &&
        other.domain == domain &&
        other.customerCode == customerCode &&
        other.id == id &&
        other.identified == identified;
  }

  @override
  int get hashCode {
    return first_name.hashCode ^
        last_name.hashCode ^
        phone.hashCode ^
        email.hashCode ^
        integration.hashCode ^
        domain.hashCode ^
        customerCode.hashCode ^
        id.hashCode ^
        identified.hashCode;
  }
}
