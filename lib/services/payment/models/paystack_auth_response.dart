import 'dart:convert';

class PaystackAuthResponse {
  String? authorizationUrl;
  String? accessCode;
  String? reference;

  PaystackAuthResponse(
    this.authorizationUrl,
    this.accessCode,
    this.reference,
  );

  PaystackAuthResponse copyWith({
    String? authorizationUrl,
    String? accessCode,
    String? reference,
  }) {
    return PaystackAuthResponse(
      authorizationUrl ?? this.authorizationUrl,
      accessCode ?? this.accessCode,
      reference ?? this.reference,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (authorizationUrl != null) {
      result.addAll({'authorizationUrl': authorizationUrl});
    }
    if (accessCode != null) {
      result.addAll({'accessCode': accessCode});
    }
    if (reference != null) {
      result.addAll({'reference': reference});
    }

    return result;
  }

  factory PaystackAuthResponse.fromMap(Map<String, dynamic> map) {
    return PaystackAuthResponse(
      map['authorizationUrl'],
      map['accessCode'],
      map['reference'],
    );
  }

  String toJson() => json.encode(toMap());

  factory PaystackAuthResponse.fromJson(String source) =>
      PaystackAuthResponse.fromMap(json.decode(source));

  @override
  String toString() =>
      'PaystackAuthResponse(authorizationUrl: $authorizationUrl, accessCode: $accessCode, reference: $reference)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PaystackAuthResponse &&
        other.authorizationUrl == authorizationUrl &&
        other.accessCode == accessCode &&
        other.reference == reference;
  }

  @override
  int get hashCode =>
      authorizationUrl.hashCode ^ accessCode.hashCode ^ reference.hashCode;
}
