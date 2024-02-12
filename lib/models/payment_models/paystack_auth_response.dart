// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

class PaystackAuthResponse {
  String? authorization_url;
  String? access_code;
  String? reference;

  PaystackAuthResponse(
    this.authorization_url,
    this.access_code,
    this.reference,
  );

  PaystackAuthResponse copyWith({
    String? authorization_url,
    String? access_code,
    String? reference,
  }) {
    return PaystackAuthResponse(
      authorization_url ?? this.authorization_url,
      access_code ?? this.access_code,
      reference ?? this.reference,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (authorization_url != null) {
      result.addAll({'authorization_url': authorization_url});
    }
    if (access_code != null) {
      result.addAll({'access_code': access_code});
    }
    if (reference != null) {
      result.addAll({'reference': reference});
    }

    return result;
  }

  factory PaystackAuthResponse.fromMap(Map<String, dynamic> map) {
    return PaystackAuthResponse(
      map['authorization_url'],
      map['access_code'],
      map['reference'],
    );
  }

  String toJson() => json.encode(toMap());

  factory PaystackAuthResponse.fromJson(String source) =>
      PaystackAuthResponse.fromMap(json.decode(source));

  @override
  String toString() =>
      'PaystackAuthResponse(authorization_url: $authorization_url, access_code: $access_code, reference: $reference)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PaystackAuthResponse &&
        other.authorization_url == authorization_url &&
        other.access_code == access_code &&
        other.reference == reference;
  }

  @override
  int get hashCode =>
      authorization_url.hashCode ^ access_code.hashCode ^ reference.hashCode;
}
