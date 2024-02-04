import 'dart:convert';

class Customer {
  String? firstName;
  String? lastName;
  String? phone;
  String? email;
  int? integration;
  String? domain;
  String? customerCode;
  int? id;
  bool? identified;

  Customer(
      this.firstName,
      this.lastName,
      this.phone,
      this.email,
      this.integration,
      this.domain,
      this.customerCode,
      this.id,
      this.identified);
  Customer copyWith({
    String? firstName,
    String? lastName,
    String? phone,
    String? email,
    int? integration,
    String? domain,
    String? customerCode,
    int? id,
    bool? identified,
  }) {
    return Customer(
      firstName ?? this.firstName,
      lastName ?? this.lastName,
      phone ?? this.phone,
      email ?? this.email,
      integration ?? this.integration,
      domain ?? this.domain,
      customerCode ?? this.customerCode,
      id ?? this.id,
      identified ?? this.identified,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (firstName != null) {
      result.addAll({'firstName': firstName});
    }
    if (lastName != null) {
      result.addAll({'lastName': lastName});
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
      map['firstName'],
      map['lastName'],
      map['phone'],
      map['email'],
      map['integration']?.toInt(),
      map['domain'],
      map['customerCode'],
      map['id']?.toInt(),
      map['identified'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Customer.fromJson(String source) =>
      Customer.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Customer(firstName: $firstName, lastName: $lastName, phone: $phone, email: $email, integration: $integration, domain: $domain, customerCode: $customerCode, id: $id, identified: $identified)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Customer &&
        other.firstName == firstName &&
        other.lastName == lastName &&
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
    return firstName.hashCode ^
        lastName.hashCode ^
        phone.hashCode ^
        email.hashCode ^
        integration.hashCode ^
        domain.hashCode ^
        customerCode.hashCode ^
        id.hashCode ^
        identified.hashCode;
  }
}
