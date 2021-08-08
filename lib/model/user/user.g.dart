// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$Data _$$DataFromJson(Map<String, dynamic> json) => _$Data(
      username: json['username'] as String,
      password: json['password'] as String,
    );

Map<String, dynamic> _$$DataToJson(_$Data instance) => <String, dynamic>{
      'username': instance.username,
      'password': instance.password,
    };

_$LoggedOut _$$LoggedOutFromJson(Map<String, dynamic> json) => _$LoggedOut();

Map<String, dynamic> _$$LoggedOutToJson(_$LoggedOut instance) =>
    <String, dynamic>{};

_$Error _$$ErrorFromJson(Map<String, dynamic> json) => _$Error(
      json['errorMsg'] as String?,
    );

Map<String, dynamic> _$$ErrorToJson(_$Error instance) => <String, dynamic>{
      'errorMsg': instance.errorMsg,
    };
