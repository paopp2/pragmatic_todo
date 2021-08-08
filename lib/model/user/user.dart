import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@freezed
class User with _$User {
  const factory User({
    required String username,
    required String password,
  }) = Data;
  const factory User.loggedOut() = LoggedOut;
  const factory User.error([String? errorMsg]) = Error;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}
