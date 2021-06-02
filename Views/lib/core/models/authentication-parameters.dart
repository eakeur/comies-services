import 'dart:convert';

import 'datamodel.dart';

class AuthenticationParameters implements DataModel {
  final String nickname;
  final String password;

  AuthenticationParameters({
    required this.nickname,
    required this.password,
  });

  AuthenticationParameters copyWith({
    String? nickname,
    String? password,
  }) {
    return AuthenticationParameters(
      nickname: nickname ?? this.nickname,
      password: password ?? this.password,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'nickname': nickname,
      'password': password,
    };
  }

  factory AuthenticationParameters.fromMap(Map<String, dynamic> map) {
    return AuthenticationParameters(
      nickname: map['nickname'],
      password: map['password'],
    );
  }

  String toJson() => json.encode(toMap());

  factory AuthenticationParameters.fromJson(String source) => AuthenticationParameters.fromMap(json.decode(source));

  @override
  String toString() => 'AuthenticationParameters(nickname: $nickname, password: $password)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is AuthenticationParameters &&
      other.nickname == nickname &&
      other.password == password;
  }

  @override
  int get hashCode => nickname.hashCode ^ password.hashCode;
}